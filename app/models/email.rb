class Email < ActiveRecord::Base
	belongs_to :a_client, class_name: "ClientInfo", foreign_key: :company_id

	#validates :name, presence: true
	validates :email, presence: true, uniqueness: { scope: :company_id, message: "Email already exists" }
	validates_format_of :email, :with => /\A[^@,\s]+@[^@,\s]+\.[^@,\s]+\z/



	@emails=[]
  	def self.import_contacts(file, company_id, user_id)
	  	the_msg = 0
		readVal =  file.read
		readVal = readVal.split(',')
		here = readVal[1].split("\r\n")

		the_company_count = the_current_count = Email.where(company_id: company_id).count()
		payment_id = ClientInfo.where(id: company_id).pluck(:payment_type)[0]
		the_official_count = PaymentType.where(id: payment_id).pluck(:email_count)[0]


		if the_official_count <= the_current_count
			return "3"
		end

		if readVal[0]=="Name" && here[0]=="Email"
        	CSV.foreach(file.path, headers: true) do |row|
        
          	if row["Email"].present?
          		check = Email.where(email: row["Email"], company_id: company_id).exists?	                
	            if check
	              the_msg =  1
	              #FailedContactUpload.create(last_name: row["last_name"], other_names: row["other_names"], mobile_no: number, mobile_money_no: mobile_money_number,  email: row["email"], desc: "Wallet number already exists", entity_id: entity_id)
	            else
	            	if the_official_count > the_current_count
						@emails << Email.new(name: row["Name"], email: row["Email"], status: true, company_id: company_id, user_id: user_id)
						the_current_count = the_current_count + 1
					else
						the_msg =  4
					end
	            end
	        else
	        end
        end  
      else
        return "2"
      end    
    
    Email.import @emails
    @emails.clear
    return the_msg
  end

end
