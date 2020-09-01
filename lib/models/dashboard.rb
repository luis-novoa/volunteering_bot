require File.expand_path('../../db/db_config', __dir__)

connect_to_db

class Dashboard < ActiveRecord::Base
  has_many :participations
end