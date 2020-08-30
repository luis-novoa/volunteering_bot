require 'active_record'
require './db/db_config.rb'

namespace :migrate do
  require File.expand_path('db/migrations/0_create_dashboard_table', __dir__)
  require File.expand_path('db/migrations/1_create_participation_table', __dir__)

  task :up do
    CreateDashboardTable.migrate(:up)
    CreateParticipationTable.migrate(:up)
  end

  task :down do
    CreateParticipationTable.migrate(:down)
    CreateDashboardTable.migrate(:down)
  end
end