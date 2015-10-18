class Audit < ActiveRecord::Base
  acts_as_commontable

	has_many :audits_practices
	has_many :audit_approvals
	has_many :audit_reviews
	has_many :audit_comments
	has_many :users, through: :audit_approvals
	has_many :users, through: :audit_reviews
	has_many :audits_practices_actions, through: :audits_practices

	belongs_to :topic
	belongs_to :user
	accepts_nested_attributes_for :audits_practices, :allow_destroy => true

	validates_presence_of :audits_practices
	validates_presence_of :audit_reviews
	validates_presence_of :audit_approvals

private

def check_valid_date
	if self.end_date < self.start_date
		errors.add(:end_date, "Invalid Date, end date can't less than start date")
	end
end



end
