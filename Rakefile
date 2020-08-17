require 'active_record'
require './db/db_config.rb'

namespace :migrate do
  task :up do
    require File.expand_path('db/migrations/0_create_user_table', __dir__)
    CreateUserTable.migrate(:up)
  end

  task :down do
    require File.expand_path('db/migrations/0_create_user_table', __dir__)
    CreateUserTable.migrate(:down)
  end
end