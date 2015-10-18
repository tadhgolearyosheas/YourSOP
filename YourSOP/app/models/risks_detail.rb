class RisksDetail < ActiveRecord::Base
	belongs_to :risk

	validates :title, :impact, :likelihood, presence: true
end
