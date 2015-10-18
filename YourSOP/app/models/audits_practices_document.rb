class AuditsPracticesDocument < ActiveRecord::Base
	belongs_to :document
	belongs_to :audits_practice
end
