require File.expand_path('../models/user', __dir__)

class UsersController
  def create(telegram_id)
    user = User.new(telegram_id: telegram_id)
    user.save
    user
  end

  def show(telegram_id)
    user = User.find_by(telegram_id: telegram_id)
    user
  end

  def index
    users = User.all
    users
  end

  def destroy(telegram_id)
    user = User.find_by(telegram_id: telegram_id)
    user.delete
    user
  end
end