class CreatePermissionsRoles < ActiveRecord::Migration
  def change
    create_table :permissions_roles do |t|
      t.integer :permission_id
      t.integer :role_id

      t.timestamps null: false
    end
  end
end
