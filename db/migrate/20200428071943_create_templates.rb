class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.string :name
      t.text :body
      t.boolean :status
      t.integer :company_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
