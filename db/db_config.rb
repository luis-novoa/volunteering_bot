require 'active_record'

def connect_to_db
  ActiveRecord::Base.establish_connection(
    adapter: 'postgresql',
    host: 'localhost',
    username: 'voluntary_role',
    password: ENV['VOLUNTEERING_DB_PASSWORD'],
    database: 'volunteering_db'
  )
end