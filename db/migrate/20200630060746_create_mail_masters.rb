class CreateMailMasters < ActiveRecord::Migration
  def change
    create_table :mail_masters do |t|
      t.string :request_code
      t.integer :email_type
      t.string :subject
      t.integer :body_template_id
      t.boolean :schedule_status
      t.datetime :schedule_time
      t.integer :email_group
      t.integer :sender_email_id
      t.integer :company_id
      t.integer :user_id
      t.boolean :status

      t.timestamps null: false
    end
  end
end
