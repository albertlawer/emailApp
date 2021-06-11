class CreateEmailsMailGroups < ActiveRecord::Migration
  def change
    create_table :emails_mail_groups do |t|
      t.integer :email_id
      t.integer :mail_group_id
      t.boolean :status
      t.integer :company_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
