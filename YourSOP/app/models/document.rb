class Document < ActiveRecord::Base
  acts_as_commontable


  
  belongs_to :user
  belongs_to :organisation
  has_many :approvals
  #validates_presence_of :approvals

  has_many :reviews
  #validates_presence_of :reviews

  has_many :readers
  has_many :trainees
  #validates_presence_of :trainees, message: "Sign off users can't be blank"
  belongs_to :topic

  has_many :risks_documents
  has_many :risks, through: :risks_documents

  belongs_to :document_topic


  has_many :document_revisions
  accepts_nested_attributes_for :document_revisions

  has_many :audits_practices_documents
  has_many :audits_practices, through: :audits_practices_documents
  

  # paperclip gem
  has_attached_file :doc, :storage => :s3, :s3_credentials => Proc.new{|a| a.instance.s3_credentials }

  do_not_validate_attachment_file_type :doc     # TODO choose valid file types

  has_many :users, through: :approvals
  has_many :users, through: :readers
  has_many :users, through: :reviews
  #has_many :users, through: :trainees

  validates :title, presence: true, length: { maximum: 255 }
  validates :status, presence: true
  validates :review_date, presence: true
  #validate :check_document_review_date
  validates :content, presence: true, unless: 'doc.present?'
  #validates_presence_of :content

def check_document_review_date
  if self.review_date != nil 
   if self.review_date < Date.today 
      errors.add(:review_date, " Can't be less than today")
   end
  end
end


def s3_credentials
  # Adding this new line
 {:bucket => "saasproject", :access_key_id => "", :secret_access_key => ""}
end 
  

end