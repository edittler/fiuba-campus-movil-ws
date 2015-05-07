class Api::Users::SearchEngineController < Api::ApiController

  # GET /api/users/search
  def basic_search
    # Check correct params
    unless exists_required_params
      render status: :bad_request,
             json: { result: "error", message: "Missing required parameters" }
      return
    end

    user = User.find_by_authentication_token(params[:user_token])

    results_by_name = Array.new
    results_by_city = Array.new
    results_by_nationality = Array.new

    if params[:query].nil?
      results_by_name = User.includes(:profile).all
    else
      name_conditions = "LOWER(profiles.first_name) LIKE ? OR LOWER(profiles.last_name) LIKE ?"
      city_conditions = "LOWER(profiles.first_name) NOT LIKE ? AND LOWER(profiles.last_name) NOT LIKE ? AND LOWER(cities.name) LIKE ?"
      nationality_conditions = "LOWER(profiles.first_name) NOT LIKE ? AND LOWER(profiles.last_name) NOT LIKE ? AND LOWER(nationalities.nationality) LIKE ?"
      query = '%' + params[:query].downcase + '%'
      #logger.debug "[API] Where query: #{query}"
      results_by_name = User.joins(:profile).where(name_conditions, query, query)
      results_by_city = User.joins(profile: [:city]).where(city_conditions, query, query, query)
      results_by_nationality = User.joins(profile: [:nationality]).where(nationality_conditions, query, query, query)
    end

    @users_by_name = user_results_by_name(user, results_by_name)
    @users_by_city = user_results_by_city(user, results_by_city)
    @users_by_nationality = user_results_by_nationality(user, results_by_nationality)

    render status: :ok
  end

  private

    def exists_required_params
      #logger.debug "[API] Basic seach, check params #{params}"
      return ( params.has_key?(:query) )
    end

    def user_hash(user)
      hash = {
        id:         user.id,
        email:      user.email,
        first_name: user.profile.first_name,
        last_name:  user.profile.last_name,
        picture:    user.profile.picture.url(:thumb)
      }
    end

    def update_user_hash_friends(user_hash)
      user_hash[:friendship] = "friends"
    end

    def update_user_hash_friendship_request_sent(user_hash)
      user_hash[:friendship] = "friendshipRequestSent"
    end

    def update_user_hash_friendship_request_pending(user_hash, friendship_request_id)
      user_hash[:friendship] = "pendingFriendshipRequest"
      user_hash[:friendship_request_id] = friendship_request_id
    end

    def user_results_by_name(seeker_user, search_result)
      users_array = Array.new

      search_result.each { |user_result|
        next if seeker_user.id == user_result.id

        user_found = user_hash user_result

        if seeker_user.friend? user_result
          update_user_hash_friends user_found
          users_array << user_found
          next
        end

        if seeker_user.friendship_request_sent? user_result
          update_user_hash_friendship_request_sent user_found
          users_array << user_found
          next
        end

        if seeker_user.friendship_request_pending? user_result
          friendship_request = FriendshipRequest.find_by(sender_user_id: user_result.id, receiver_user_id: seeker_user.id)
          update_user_hash_friendship_request_pending(user_found, friendship_request.id)
          users_array << user_found
          next
        end

        users_array << user_found
      }
      logger.debug "[API] Users by name found: #{users_array}"
      return users_array
    end

    def user_results_by_city(seeker_user, search_result)
      users_array = Array.new

      search_result.each { |user_result|
        next if seeker_user.id == user_result.id

        user_found = user_hash user_result
        user_found[:match] = user_result.profile.city.name

        if seeker_user.friend? user_result
          update_user_hash_friends user_found
          users_array << user_found
          next
        end

        if seeker_user.friendship_request_sent? user_result
          update_user_hash_friendship_request_sent user_found
          users_array << user_found
          next
        end

        if seeker_user.friendship_request_pending? user_result
          friendship_request = FriendshipRequest.find_by(sender_user_id: user_result.id, receiver_user_id: seeker_user.id)
          update_user_hash_friendship_request_pending(user_found, friendship_request.id)
          users_array << user_found
          next
        end

        users_array << user_found
      }
      logger.debug "[API] Users by city found: #{users_array}"
      return users_array
    end

    def user_results_by_nationality(seeker_user, search_result)
      users_array = Array.new

      search_result.each { |user_result|
        next if seeker_user.id == user_result.id

        user_found = user_hash user_result
        user_found[:match] = user_result.profile.nationality.nationality

        if seeker_user.friend? user_result
          update_user_hash_friends user_found
          users_array << user_found
          next
        end

        if seeker_user.friendship_request_sent? user_result
          update_user_hash_friendship_request_sent user_found
          users_array << user_found
          next
        end

        if seeker_user.friendship_request_pending? user_result
          friendship_request = FriendshipRequest.find_by(sender_user_id: user_result.id, receiver_user_id: seeker_user.id)
          update_user_hash_friendship_request_pending(user_found, friendship_request.id)
          users_array << user_found
          next
        end

        users_array << user_found
      }
      logger.debug "[API] Users by nationality found: #{users_array}"
      return users_array
    end

end
