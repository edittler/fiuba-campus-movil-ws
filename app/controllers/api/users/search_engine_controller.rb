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

    search_results = Array.new
    if params[:query].nil?
      search_results = User.includes(:profile).all
    else
      conditions = "LOWER(profiles.first_name) LIKE ? OR LOWER(profiles.last_name) LIKE ? OR LOWER(nationalities.nationality) LIKE ? OR LOWER(cities.name) LIKE ?"
      query = '%' + params[:query].downcase + '%'
      logger.debug "[API] Where query: #{query}"
      search_results = User.joins(profile: [:nationality, :city]).where(conditions, query, query, query, query)
    end
    logger.debug "[API] Search result: #{search_results.inspect}"

    @users_found = Array.new

    search_results.each { |user_result|
      next if user.id == user_result.id

      user_found = {
        id: user_result.id,
        email: user_result.email,
        first_name: user_result.profile.first_name,
        last_name: user_result.profile.last_name
      }

      if Friendship.exists?(this_user_id: user.id, other_user_id: user_result.id)
        logger.debug "[API] Friendship!!!"
        user_found[:friendship] = "friends"
        @users_found << user_found
        next
      end

      if FriendshipRequest.exists?(sender_user_id: user.id, receiver_user_id: user_result.id)
        logger.debug "[API] Friendship request sent!!!"
        user_found[:friendship] = "friendshipRequestSent"
        @users_found << user_found
        next
      end

      if FriendshipRequest.exists?(sender_user_id: user_result.id, receiver_user_id: user.id)
        logger.debug "[API] Pending friendship request!!!"
        friendship_request = FriendshipRequest.find_by(sender_user_id: user_result.id, receiver_user_id: user.id)
        user_found[:friendship] = "pendingFriendshipRequest"
        user_found[:friendship_request_id] = friendship_request.id
        @users_found << user_found
        next
      end

      @users_found << user_found
    }
    logger.debug "[API] Users found: #{@users_found}"

    render status: :ok
  end

  private

    def exists_required_params
      logger.debug "[API] Basic seach, check params #{params}"
      return ( params.has_key?(:query) )
    end

end
