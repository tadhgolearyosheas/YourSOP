module ApplicationHelper
  @@USER_TYPE_QUALITY = 0
  @@USER_TYPE_BASIC = 1
  @@USER_TYPE_OWNER = 2

  def user_type_to_string type
    case type
      when @@USER_TYPE_QUALITY
        'Quality'
      when @@USER_TYPE_BASIC
        'Basic'
      when @@USER_TYPE_OWNER
        'Owner'
      else
        'Unknown'
    end
  end

  def is_owner type
    type == @@USER_TYPE_OWNER ? true : false
  end

  def is_quality type
    type == @@USER_TYPE_QUALITY ? true : false
  end

  def is_basic type
    type == @@USER_TYPE_BASIC ? true : false
  end
  
  def is_current_user_quality_or_owner
    user_type = OrganisationUser.where(user: current_user, organisation: @current_organisation)[0].user_type
    is_quality(user_type) or is_owner(user_type)
  end

  def controller?(*controller)
    controller.include?(params[:controller])
  end

  def action?(*action)
    action.include?(params[:action])
  end

  def risk_impact_to_string impact
    if impact == 1
      'Negligible'
    elsif impact == 2
      'Minor'
    elsif impact == 3
      'Moderate'
    elsif impact == 4
      'Major'
    elsif impact == 5
      'Extreme'
    else
      'Unknown'
    end
  end

  def risk_likelihood_to_string likelihood
    if likelihood == 1
      'Rare/Remote'
    elsif likelihood == 2
      'Unlikely'
    elsif likelihood == 3
      'Possible'
    elsif likelihood == 4
      'Likely'
    elsif likelihood == 5
      'Almost Certain'
    else
      'Unknown'
    end
   end
  
end
