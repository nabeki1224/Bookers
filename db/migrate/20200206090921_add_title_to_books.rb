class AddTitleToBooks < ActiveRecord::Migration[5.2]
  def change
  	create_table :books do |t|
  		t.string :title
  		t.text :body
  		t.integer :user_id
  	end
  end
end
