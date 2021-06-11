class CreateMailGroups < ActiveRecord::Migration
  def change
    create_table :mail_groups do |t|
      t.string :name
      t.string :description
      t.boolean :status
      t.integer :company_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
