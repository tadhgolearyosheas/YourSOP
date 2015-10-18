class Organisation < ActiveRecord::Base
  belongs_to :user

  has_many :documents
  has_many :document_types

  has_many :topics
  has_many :risks

  has_many :document_topics


  has_many :organisation_users
  has_many :users, through: :organisation_users

  validates_uniqueness_of :name
  validates :name, presence: true

  validates_uniqueness_of :gms_code
  validates :gms_code, presence: true


  # has_many :pending_users
end
