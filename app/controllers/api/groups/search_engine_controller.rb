class Api::Groups::SearchEngineController < Api::ApiController

  # GET /api/users/search
  def basic_search
    # Check correct params
    unless exists_required_params
      render_missing_required_params
      return
    end

    user = User.find_by_authentication_token(params[:user_token])

    results_by_name = Array.new

    if params[:query].nil?
      results_by_name = Group.all
    else
      name_conditions = "LOWER(groups.name) LIKE ?"
      query = '%' + params[:query].downcase + '%'
      #logger.debug "[API] Where query: #{query}"
      results_by_name = Group.where(name_conditions, query)
    end

    @groups_by_name = group_results_by_name(user, results_by_name)

    render status: :ok
  end

  private

    def exists_required_params
      #logger.debug "[API] Basic seach, check params #{params}"
      return ( params.has_key?(:query) )
    end

    def group_hash(group)
      hash = {
        id:          group.id,
        name:        group.name,
        description: group.description
      }
    end

    def group_results_by_name(seeker_user, search_result)
      groups_array = Array.new

      search_result.each { |group_result|
        group_found = group_hash group_result

        if seeker_user.in_group?(group_result)
          group_found[:is_member] = true
        else
          group_found[:is_member] = false
        end

        groups_array << group_found
      }
      logger.debug "[API] Groups by name found: #{groups_array}"
      return groups_array
    end

end
