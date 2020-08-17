require 'active_record'
require './db/db_config.rb'

namespace :migrate do
  require File.expand_path('db/migrations/0_create_user_table', __dir__)
  require File.expand_path('db/migrations/1_create_dashboard_table', __dir__)
  require File.expand_path('db/migrations/2_create_participation_table', __dir__)

  task :up do
    CreateUserTable.migrate(:up)
    CreateDashboardTable.migrate(:up)
    CreateParticipationTable.migrate(:up)
  end

  task :down do
    CreateParticipationTable.migrate(:down)
    CreateDashboardTable.migrate(:down)
    CreateUserTable.migrate(:down)
  end
end