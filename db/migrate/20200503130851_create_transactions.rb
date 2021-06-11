class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :request_master_id
      t.integer :email_id
      t.string :subject
      t.string :from_mail
      t.text :body_message
      t.boolean :status
      t.integer :user_id
      t.integer :company_id

      t.timestamps null: false
    end
  end
end
