class OrganisationService < ActiveRecord::Base
	belongs_to :services
	belongs_to :organisations
end
