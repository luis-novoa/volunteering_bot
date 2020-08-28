require File.expand_path('../db_config', __dir__)

connect_to_db

class CreateUserTable < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |table|
      table.string :telegram_id
      table.timestamps
    end
  end
end