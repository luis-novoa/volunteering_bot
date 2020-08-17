require 'active_record'
require './db/db_config.rb'

namespace :migrate do
  task :up do
    require File.expand_path('db/migrations/0_create_user_table', __dir__)
    require File.expand_path('db/migrations/1_create_dashboard_table', __dir__)
    CreateUserTable.migrate(:up)
    CreateDashboardTable.migrate(:up)
  end

  task :down do
    require File.expand_path('db/migrations/0_create_user_table', __dir__)
    require File.expand_path('db/migrations/1_create_dashboard_table', __dir__)
    CreateUserTable.migrate(:down)
    CreateDashboardTable.migrate(:down)
  end
end