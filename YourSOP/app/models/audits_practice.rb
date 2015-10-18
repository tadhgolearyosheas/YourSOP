class AuditsPractice < ActiveRecord::Base
	belongs_to :audit
	has_many :audits_practices_documents
	has_many :documents, through: :audits_practices_documents

	has_many :audits_practices_actions

	has_attached_file :attachment, :storage => :s3, :s3_credentials => Proc.new{|a| a.instance.s3_credentials }
  	do_not_validate_attachment_file_type :attachment

  	validates_presence_of :audits_practices_documents

  	accepts_nested_attributes_for :audits_practices_actions, :allow_destroy => true, :reject_if => proc { |attributes| attributes['action'].blank? }

	# Adding this new line
	 def s3_credentials
	   {:bucket => "saasproject", :access_key_id => "", :secret_access_key => ""}
	 end
end
