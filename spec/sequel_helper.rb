require 'sequel'

DB = Sequel.connect(ENV['DATABASE_URL'] || "jdbc:postgresql://localhost/reservoir")
Sequel::Model.db = DB

DB.create_table?(:dealerships) do
  primary_key :id
  column :identifier, String
end

require 'lib/reservoir/dealership/sequel_repository'
