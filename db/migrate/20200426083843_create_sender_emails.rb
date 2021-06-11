class CreateSenderEmails < ActiveRecord::Migration
  def change
    create_table :sender_emails do |t|
      t.string :name
      t.string :email_username
      t.string :email_password
      t.string :email_address
      t.string :email_port
      t.string :authentication
      t.integer :company_id
      t.integer :user_id
      t.boolean :status

      t.timestamps null: false
    end
  end
end
