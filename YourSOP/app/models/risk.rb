class Risk < ActiveRecord::Base
  	belongs_to :user
  	belongs_to :organisation
    belongs_to :topic
  	has_many :risks_details

  	accepts_nested_attributes_for :risks_details, :allow_destroy => true, reject_if: proc { |attributes| attributes['title'].blank? }
  	
  	validates_presence_of :risks_details
end
