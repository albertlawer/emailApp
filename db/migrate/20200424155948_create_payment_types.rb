class CreatePaymentTypes < ActiveRecord::Migration
  def change
    create_table :payment_types do |t|
      t.string :name
      t.string :body
      t.integer :users
      t.integer :email_count
      t.integer :email_book
      t.integer :email_templates
      t.integer :sender_email

      t.timestamps null: false
    end
  end
end
