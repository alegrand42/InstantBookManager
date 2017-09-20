class AddDescriptionToUploads < ActiveRecord::Migration[5.1]
  def change
    add_column :uploads, :title, :string
    add_column :uploads, :description, :text
    add_column :uploads, :author, :string
    add_column :uploads, :editor, :string
  end
end
