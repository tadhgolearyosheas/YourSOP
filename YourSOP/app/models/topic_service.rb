class TopicService < ActiveRecord::Base
	belongs_to :topics
	belongs_to :services
end
