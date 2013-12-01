# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if ENV['SEED_DATA'] == 'set1'
  require 'sqlite3'
  db_name = "db/data_nyc.sqlite"
  table = "Summons_SelectFields_BigApps_v1"
  db = SQLite3::Database.new(db_name)
  number_of_rows = (db.execute "SELECT COUNT(*) FROM #{table}").flatten.first
  puts "there are #{number_of_rows} records in the database"

  chunk_size = 10

  puts "Importing records in chucnks of #{chunk_size}"

  current_number = 20000

  puts db.execute "SELECT * FROM sqlite_master WHERE type='table'"

  500.times do

    puts "Importing record #{current_number + 10} of #{number_of_rows} (#{(current_number.to_f/number_of_rows.to_f).round(3)*100}% done)"
    results =  (db.execute "SELECT * FROM #{table} LIMIT #{chunk_size} OFFSET #{current_number}")
    results.each do |row|
      loc = Location.create(user_submission: "#{row[10].strip} #{row[11].strip}, New York, NY")
      Ticket.create(user_id: 1, location_id: loc.id, issued_at: row[4].strip.to_datetime, fine: row[7].strip.to_i, violation: row[5].squeeze(" ") )
    end
    current_number += chunk_size

  end

else
  require 'csv'
  tickets_csv = CSV.open("db/parking_tickets.csv")
#	current_batch = (2..25)
	tickets_csv.each_with_index  do |row, i|
    if i > 2 && i < 25
    loc = Location.create(user_submission: "#{row[10]} #{row[11]}, New York, NY")
		Ticket.create(user_id: 1, location_id: loc.id, issued_at: row[4].to_datetime, fine: row[7].strip.to_i, violation: row[5].squeeze(" ") )
		p row[10]
		p row[11]
		end
  end


end

