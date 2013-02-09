require 'sequel'

DB = Sequel.connect(ENV['DATABASE_URL'] || "jdbc:postgresql://localhost/reservoir")
Sequel::Model.db = DB

DB.create_table?(:dealerships) do
  primary_key :id
  column :key, String
  column :name, String
  column :created, Bignum
  column :deleted, FalseClass, :default => false
end

DB.create_table?(:vehicles) do
  primary_key :id
  column :key, String
end
