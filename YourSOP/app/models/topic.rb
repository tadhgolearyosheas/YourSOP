class Topic < ActiveRecord::Base
	belongs_to :organisation
	has_many :risks
	has_many :documents

  	has_many :audits
  	has_many :audits_practices, through: :audits

	validates :name, :description, :status, presence: true
end
