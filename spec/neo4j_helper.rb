require 'neo4j'

# Configure location of database
Neo4j::Config[:storage_path] = "/tmp/db"

require 'lib/reservoir/dealership/neo4j_repository'
