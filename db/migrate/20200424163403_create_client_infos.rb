class CreateClientInfos < ActiveRecord::Migration
  def change
    create_table :client_infos do |t|
      t.string :name
      t.string :email
      t.string :phone_one
      t.string :phone_two
      t.integer :payment_type
      t.date :expiry_date
      t.boolean :status

      t.timestamps null: false
    end
  end
end
