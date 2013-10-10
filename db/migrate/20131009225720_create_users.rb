class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :email
    	t.string :password_digest
    	t.string :user_type
    	t.integer :home_id
      t.timestamps
    end
  end
end
