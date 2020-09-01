require File.expand_path('../db_config', __dir__)

connect_to_db

class CreateParticipationTable < ActiveRecord::Migration[6.0]
  def change
    create_table :participations do |table|
      table.integer :level
      table.boolean :active
      table.string :user_id, null: false
      table.references :dashboard, null: false, foreign_key: true
      table.timestamps
    end
  end
end