class User < ActiveRecord::Base
  acts_as_commontator
  acts_as_messageable

  has_many :auditers
  has_many :audits, through: :auditers
  has_many :organisations
  has_many :approvals
  has_many :reviews
  has_many :trainees
  has_many :documents
  has_many :organisation_users
  has_many :audit_comments
  has_many :users

  has_many :documents, through: :approvals
  has_many :documents, through: :readers
  has_many :documents, through: :reviews
  #has_many :documents, through: :trainees
  has_many :organisations, through: :organisation_users
  has_many :audits_practices_actions

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

 #validates_uniqueness_of :email
 #validates :email, presence: true

 validates :name, presence: true, on: :create
 validates_uniqueness_of :name

 #validates :encrypted_password, presence: true



  def mailboxer_email(object)
    email
  end

end
