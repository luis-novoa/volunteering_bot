require File.expand_path('../models/dashboard', __dir__)

class DashboardsController
  def create(type, entrance_fee)
    new_dashboard = Dashboard.new(type: type, entrance_fee: entrance_fee)
    new_dashboard.save
    new_dashboard
  end

  def show(type, entrance_fee)
    dashboard = Dashboard.find_by(type: type, entrance_fee: entrance_fee)
    dashboard
  end

  def index
    dashboard = Dashboard.all
    dashboard
  end

  def destroy(type, entrance_fee)
    dashboard = Dashboard.find_by(type: type, entrance_fee: entrance_fee)
    dashboard.delete
    dashboard
  end
end
