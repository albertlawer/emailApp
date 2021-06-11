class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :name
      t.string :email
      t.boolean :status
      t.integer :company_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
