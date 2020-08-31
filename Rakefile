require 'active_record'
require './db/db_config.rb'
require File.expand_path('./lib/models/dashboard', __dir__)
require File.expand_path('./lib/models/participation', __dir__)

namespace :migrate do
  require File.expand_path('db/migrations/0_create_dashboard_table', __dir__)
  require File.expand_path('db/migrations/1_create_participation_table', __dir__)

  task :up do
    CreateDashboardTable.migrate(:up)
    CreateParticipationTable.migrate(:up)
    Dashboard.create(dashboard_type: 'long', entrance_fee: '50')
    Dashboard.create(dashboard_type: 'long', entrance_fee: '100')
    Dashboard.create(dashboard_type: 'short', entrance_fee: '50')
    Dashboard.create(dashboard_type: 'short', entrance_fee: '100')
  end

  task :down do
    CreateParticipationTable.migrate(:down)
    CreateDashboardTable.migrate(:down)
  end
end