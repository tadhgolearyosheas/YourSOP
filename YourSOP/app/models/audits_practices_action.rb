class AuditsPracticesAction < ActiveRecord::Base
	belongs_to :audits_practice
	belongs_to :user

	validates :action, :user_id, presence: true
end
