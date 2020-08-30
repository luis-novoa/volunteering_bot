require File.expand_path('./lib/models/dashboard', __dir__)

Dashboard.create(dashboard_type: 'long', entrance_fee: '50')
Dashboard.create(dashboard_type: 'long', entrance_fee: '100')
Dashboard.create(dashboard_type: 'short', entrance_fee: '50')
Dashboard.create(dashboard_type: 'short', entrance_fee: '100')