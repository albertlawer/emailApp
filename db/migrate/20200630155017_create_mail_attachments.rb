class CreateMailAttachments < ActiveRecord::Migration
  def change
    create_table :mail_attachments do |t|
      t.string :request_code
      t.string :attachment_name
      t.string :attachment_path
      t.boolean :status

      t.timestamps null: false
    end
  end
end
