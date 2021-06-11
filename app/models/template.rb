class Template < ActiveRecord::Base
  belongs_to :a_client, class_name: "ClientInfo", foreign_key: :company_id

  validates :name, presence: true, uniqueness: { scope: :company_id, message: "Name already exists" }
  validates :body, presence: true
  validate :the_body

  def the_body
  	if self.body == "<p><br></p>"
  		errors.add(:name, "and body cannot be blank")
  	end
  end
end
