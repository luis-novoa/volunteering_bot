require File.expand_path('../../db/db_config', __dir__)

connect_to_db

class Participation < ActiveRecord::Base
  belongs_to :user
  belongs_to :dashboard
end