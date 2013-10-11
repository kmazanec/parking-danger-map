require 'active_mdb'
require 'active_mdb/mdb_tools'
require 'faster_csv'
class Seeder < ActiveMDB::Base

  set_mdb_file '/db/ParkingTickets.mdb'
end

headers = Seeder.column_names

p headers
