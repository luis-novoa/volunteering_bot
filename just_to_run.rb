require File.expand_path('./lib/models/dashboard', __dir__)
require File.expand_path('./lib/models/participation', __dir__)

Dashboard.create(dashboard_type: 'long', entrance_fee: '50')
Dashboard.create(dashboard_type: 'long', entrance_fee: '100')
dashboard = Dashboard.create(dashboard_type: 'short', entrance_fee: '50')
Dashboard.create(dashboard_type: 'short', entrance_fee: '100')

dashboard.participations.build(user_id: 111111111, level: 1, active: true).save
dashboard.participations.build(user_id: 111111112, level: 1, active: true).save

dashboard.participations.build(user_id: 111111113, level: 2, active: true).save
dashboard.participations.build(user_id: 111111114, level: 2, active: true).save
dashboard.participations.build(user_id: 111111115, level: 3, active: true).save
dashboard.participations.build(user_id: 111111116, level: 1, active: true).save
dashboard.participations.build(user_id: 111111117, level: 1, active: false).save