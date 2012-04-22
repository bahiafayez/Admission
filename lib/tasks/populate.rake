namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    
    #[Category, Product, Person].each(&:delete_all)
    [User, Applicant, Semester, School, Address, AdmissionInformation, Major, Guardian, SecondarySchool, College, Work, Health, Attachment, UniRelatedInfo, UniChoice, OtherChoice].each(&:delete_all)
    
    Semester.populate 4 do |semester|
      semester.name= "Spring #{semester.id}"
      semester.status=[true,false]
      semester.created_at=2.weeks.ago..Time.now
      semester.updated_at=2.weeks.ago..Time.now
      
      
      School.populate 2..4 do |program|
        
        program.name= Populator.words(1..5).titleize
        program.status=[true,false]
        program.created_at=2.weeks.ago..Time.now
        program.updated_at=2.weeks.ago..Time.now
        
        Major.populate 2..4 do |major|
          major.name= Populator.words(1..5).titleize
          major.status=[true,false]
          major.created_at=2.weeks.ago..Time.now
          major.updated_at=2.weeks.ago..Time.now
          major.school_id=program.id
      
          User.populate 10 do |person|
            person.email   = Faker::Internet.email
            actual_password = "password"
            #digest = "#{actual_password}#{person.password_salt}"
            pepper = nil
            cost = 10 
            person.encrypted_password = ::BCrypt::Password.create("#{actual_password}#{pepper}", :cost => cost).to_s
            #person.encrypted_password = Digest::SHA1.hexdigest(digest)
            person.created_at=2.weeks.ago..Time.now
            person.updated_at=2.weeks.ago..Time.now
      
            Applicant.populate 1 do |applicant|
              applicant.user_id = person.id
              applicant.first_name=Faker::Name.name
              applicant.middle_name=Faker::Name.name
              applicant.last_name=Faker::Name.name
              applicant.date_of_birth=20.years.ago..18.years.ago
              applicant.place_of_birth=Faker::Address.city
              applicant.gender=["Male","Female"]
              applicant.military_status=["Exempted","Postponed"]
              applicant.national_id=1..500
              applicant.national_id_expiry_date=Time.now..2.years.from_now
              applicant.transportation=["Private", "Nu buses"]
              applicant.status=["Saved","Submitted", "Approved", "Rejected"]
              applicant.created_at=2.weeks.ago..Time.now
              applicant.updated_at=2.weeks.ago..Time.now
                
              Address.populate 1..2 do |address|
                address.applicant_id=applicant.id
                address.address= "#{Faker::Address.street_address}, #{Faker::Address.city} "
                address.telephone=Faker::PhoneNumber.phone_number
                address.mobile=Faker::PhoneNumber.phone_number
                address.fax= Faker::PhoneNumber.phone_number
                address.address_type=["Both", "Mailing Address", "Home Address"]
                address.created_at=2.weeks.ago..Time.now
                address.updated_at=2.weeks.ago..Time.now
              end
              
              AdmissionInformation.populate 1 do |ad|
                ad.applicant_id=applicant.id
                ad.toefl_test_date= Time.now..7.days.from_now
                ad.toefl_test_results=450..650
                ad.proficiency_test=[true, false]
                ad.school_id=program.id
                ad.semester_id=semester.id
                ad.major_id=major.id
                ad.created_at=2.weeks.ago..Time.now
                ad.updated_at=2.weeks.ago..Time.now
              end
              
              Guardian.populate 2 do |g|
                g.applicant_id=applicant.id
                g.first_name= Faker::Name.name
                g.middle_name=Faker::Name.name
                g.last_name=Faker::Name.name
                g.address="#{Faker::Address.street_address}, #{Faker::Address.city} "
                g.telephone=Faker::PhoneNumber.phone_number
                g.mobile=Faker::PhoneNumber.phone_number
                g.created_at=2.weeks.ago..Time.now
                g.updated_at=2.weeks.ago..Time.now
                g.occupation=Faker::Company.bs
                g.company_name=Faker::Company.name
                g.business_telephone=Faker::PhoneNumber.phone_number
                g.email=Faker::Internet.email
                g.fax=Faker::PhoneNumber.phone_number
                g.business_address="#{Faker::Address.street_address}, #{Faker::Address.city} "
                g.relation=["Mother", "Father"]
                g.financial=[true,false]         
              end
              SecondarySchool.populate 1..2 do |s|
                s.applicant_id=applicant.id
                s.name= Faker::Name.name
                s.address="#{Faker::Address.street_address}, #{Faker::Address.city} "
                s.language = Populator.words(1..1).titleize
                s.attended_from=14.years.ago..12.years.ago
                s.attended_to=4.years.ago..Time.now
                s.certificate_type=["Thanaweya Amma", "IG", "GCSE", "American Diploma"]
                s.created_at=2.weeks.ago..Time.now
                s.updated_at=2.weeks.ago..Time.now
                s.graduation_date=1.year.ago..Time.now
                s.school_type=["Private", "Public"]        
              end
              College.populate 0..2 do |c|
                c.applicant_id=applicant.id
                c.name= Populator.words(1..1).titleize
                c.faculty=Populator.words(1..1).titleize
                c.major = Populator.words(1..1).titleize
                c.attended_from=14.years.ago..12.years.ago
                c.attended_to=4.years.ago..Time.now
                c.city=Faker::Address.city
                c.created_at=2.weeks.ago..Time.now
                c.updated_at=2.weeks.ago..Time.now
                c.country=Populator.words(1..1).titleize
                c.language=Populator.words(1..1).titleize   
                c.gpa=0..5  
              end
              Work.populate 0..2 do |w|
                w.applicant_id=applicant.id
                w.employer= Faker::Company.name
                w.worked_from=4.years.ago..1.year.ago
                w.worked_to=4.years.ago..1.year.ago
                w.tasks=Populator.sentences(2..4)
                w.created_at=2.weeks.ago..Time.now
                w.updated_at=2.weeks.ago..Time.now       
              end
              Health.populate 0..2 do |h|
                h.applicant_id=applicant.id
                h.description= Populator.sentences(2..4)
                h.illness= Populator.words(1..3).titleize
                h.created_at=2.weeks.ago..Time.now
                h.updated_at=2.weeks.ago..Time.now        
              end
              Attachment.populate 1 do |attach|
                attach.applicant_id=applicant.id
              end
              UniRelatedInfo.populate 1 do |uni|
                uni.applicant_id=applicant.id
                UniChoice.populate 1 do |choice|
                  choice.uni_related_info_id=uni.id
                end
                OtherChoice.populate 1 do |other|
                  other.uni_related_info_id=uni.id
                end
              end
            end
          end
        end
      end
    end
   
    

    
    # User.populate 20 do |category|
      # category.name = Populator.words(1..3).titleize
      # Product.populate 10..100 do |product|
        # product.category_id = category.id
        # product.name = Populator.words(1..5).titleize
        # product.description = Populator.sentences(2..10)
        # product.price = [4.99, 19.95, 100]
        # product.created_at = 2.years.ago..Time.now
      # end
    # end
#     
    # Person.populate 100 do |person|
      # person.name    = Faker::Name.name
      # person.company = Faker::Company.name
      # person.email   = Faker::Internet.email
      # person.phone   = Faker::PhoneNumber.phone_number
      # person.street  = Faker::Address.street_address
      # person.city    = Faker::Address.city
      # person.state   = Faker::Address.us_state_abbr
      # person.zip     = Faker::Address.zip_code
    # end
  end
end