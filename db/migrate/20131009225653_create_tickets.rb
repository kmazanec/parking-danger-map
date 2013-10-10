class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
    	t.integer :location_id
    	t.integer :user_id
    	t.integer :fine
    	t.string :officer
    	t.datetime :issued_at
    	t.string :status
    	t.string :violation
      t.timestamps
    end
  end
end
