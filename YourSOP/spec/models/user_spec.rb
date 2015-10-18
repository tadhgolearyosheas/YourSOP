require 'spec_helper'
require 'rails_helper'

RSpec.describe User, type: :model do

it "is invalid with a blank user" do
    user = User.new
	expect(user).not_to be_valid
	end
	
it "is invalid that a user without email" do
    user = User.new(email: nil)
	user.valid?
	expect(user.errors[:email]).to include("can't be blank") 
	end
	
it "is invalid that a user without password" do
    user = User.new(password: nil)
    user.valid?	
	expect(user.errors[:password]).to include{"can't be blank"}
	end		


describe User do 
	u1 = User.new()
	it "has doc file name 'test1'" do
		u1.doc_file_name = "test1"
		u1.doc_file_name.should match("test1")
	end

	it "has doc content type 'new'" do
		u1.doc_content_type = "new"
		u1.doc_content_type.should match("new")
	end

	it "has doc file size as 255" do
		u1.doc_file_size = 255
		u1.doc_file_size.should match(255)
	end

	it "has a doc updated at today" do
		u1.doc_updated_at = Date.new
		u1.doc_updated_at.should match(Date.new)
	end

	it "has a email '123@qq.com'" do
		u1.email = "123@qq.com"
		u1.email.should match("123@qq.com")
	end

	it "has a encrypted password '1a2s3c'" do
		u1.encrypted_password = "1a2b3c"
		u1.encrypted_password.should match("1a2b3c")
	end

	it "reset password token '3c2b1a'" do
		u1.reset_password_token = "3c2b1a"
		u1.reset_password_token.should match("3c2b1a")
	end

	it "reset password at today" do
		u1.reset_password_sent_at = Date.new
		u1.reset_password_sent_at.should match(Date.new)
	end

	it "is remembered at today" do
		u1.remember_created_at = Date.new
		u1.remember_created_at.should match(Date.new)
	end

	it "is sign in " do
		u1.sign_in_count = 1
		u1.sign_in_count.should match(1)
	end

	it "sign in at today" do
		u1.current_sign_in_at = Date.new
		u1.current_sign_in_at.should match(Date.new)
	end

	it "last sign in at today" do
		u1.last_sign_in_at = Date.new
		u1.last_sign_in_at.should match(Date.new)
	end

	it "current sign in ip is '111.111.111.1'" do
		u1.current_sign_in_ip = "111.111.111.1"
		u1.current_sign_in_ip.should match("111.111.111.1")
	end

	it "last sign in ip is '111.111.11.1'" do
		u1.last_sign_in_ip = "111.111.11.1" 
		u1.last_sign_in_ip.should match("111.111.11.1")
	end

	it "is created at today" do
		u1.created_at = Date.new
		u1.created_at.should match(Date.new)
	end	
 end
end