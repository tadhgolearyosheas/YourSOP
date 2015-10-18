desc "Populate DB"
task :feed_data => :environment do 
  
    

    
        5.times do

            org = Organisation.new
            nam = "ORGANISATION"
            org.name = "#{nam}-#{rand(1..10000)}"
            org.user_id = User.order("RANDOM()").first.id 
        
            org.save
        5.times do
          user = User.new
        
        mid = "QMS"
        user.email = "#{rand(1..1000)}@#{mid}"
        user.password = "12345678"
        user.reset_password_token = nil
        user.reset_password_sent_at = nil
        user.remember_created_at = nil
        user.sign_in_count = rand(1..50)
        time = Time.new
        user.current_sign_in_at = time.strftime("%Y-%m-%d %H:%M:%S")
        user.last_sign_in_at = time.strftime("%Y-%m-%d %H:%M:%S")
        user.current_sign_in_ip = Faker::Internet.ip_v4_address
        user.last_sign_in_ip = Faker::Internet.ip_v4_address
    user.save

         ouser = OrganisationUser.new
         ouser.accepted = true
         ouser.user_type = [0,1,2].shuffle.first
         ouser.user_id = user.id            
         ouser.organisation_id = org.id         
         ouser.inviter_id = org.user_id
         ouser.save
     3.times do
    doc1 = Document.new
        name = "Doc"
        fname ="File"
        doc1.title = "#{name}-#{rand(25..10000)}"
        doc1.status = [0,1,2].shuffle.first
        doc1.user_id = OrganisationUser.where(:organisation_id => org.id).order("RANDOM()").first.user_id
        doc1.organisation_id = org.id  
        doc1.doc_file_name = "#{fname}-#{rand(25..10000)}"
        doc1.doc_content_type =nil
        doc1.doc_file_size =nil
        doc1.doc_updated_at = Date.today
        doc1.content =Faker::Lorem.paragraph(2, true)
    doc1.save

    rev = Review.new
    rev.status = 0
    rev.document_id = Document.order("RANDOM()").first.id          
    rev.user_id =org.user_id                                        
    rev.save


    app = Approval.new
    app.status = 0
    app.document_id = Document.order("RANDOM()").first.id
    app.user_id = OrganisationUser.where(:organisation_id => org.id).order("RANDOM()").first.user_id                                   
    app.save


    topic = Topic.new
    topic.name = ["X-Ray","HMRI","Medical Devise software system"].shuffle.first
    topic.description=Faker::Lorem.paragraph(1, true)
    topic.status= 1
    topic.organisation_id = org.id   
    topic.last_audit_date = Date.today - 20.days
    topic.save

    ri = RisksImpact.new
    ri.name = ["Injury","Service User Experience","Compliance with Standards (Statutory, Clinical, Professional & Management)","Objectives/Projects","Business Continuity","Adverse publicity/ Reputation","Financial Loss (per local Contact)","Environment"].shuffle.first
    ri.impact = ["Negligible","Minor","Moderate","Major","Extreme"].shuffle.first       
    case ri.impact
    when "Negiligible"
        ri.value = 5   
    when "Minor"     
        ri.value = 10
    when "Moderate"  
        ri.value = 15
    when "Major"   
        ri.value = 20
    when "Extreme"    
        ri.value = 30
    end

    ri.description = Faker::Lorem.paragraph(1, true)
    ri.save

    end
end
    
end
end

