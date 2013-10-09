class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|

      t.timestamps
    end
  end
end
