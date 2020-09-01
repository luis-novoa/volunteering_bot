require File.expand_path('../models/participations', __dir__)

class ParticipationsController
  def create(user_id, dashboard_id)
    participation = Participation.New(user_id: user_id, dashboard_id: dashboard_id, active: false, level: 1)
    participation.save
    participation
  end

  def index
    participations = Participation.all
    participations
  end

  def update(user_id, dashboard_id, active = nil, upgrade = false)
    participation = Participation.find_by(user_id: user_id, dashboard_id: dashboard_id)
    new_level = participation.level + 1 if upgrade
    participation.update(active: active, level: new_level)
    participation
  end
end