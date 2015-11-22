# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# Date
# ----------------------------
Date::DATE_FORMATS[:default] = "%e/%B/%Y" 

# DateTime / Time
# ----------------------------
Time::DATE_FORMATS[:default] = "%m/%d/%Y %I:%M %p"