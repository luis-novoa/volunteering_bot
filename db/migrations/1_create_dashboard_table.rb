require File.expand_path('../db_config', __dir__)

connect_to_db

class CreateDashboardTable < ActiveRecord::Migration[6.0]
  def change
    create_table :dashboards do |table|
      table.string :type
      table.integer :entrance_fee
      table.timestamps
    end
  end
end