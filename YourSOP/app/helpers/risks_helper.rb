module RisksHelper

    def if_current_user_is_quality
        if @current_organisation == nil
            return false
        end
        user_type = OrganisationUser.where(user: current_user, organisation: @current_organisation)[0].user_type
        return is_quality(user_type) || is_owner(user_type)
    end

end
