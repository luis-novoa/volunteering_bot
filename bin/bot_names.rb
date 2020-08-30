require 'telegram/bot'
require_relative('./values.rb')
require_relative('../lib/controllers/bots_controllers.rb')
require File.expand_path('../lib/models/participation', __dir__)
require File.expand_path('../lib/models/dashboard', __dir__)
token = @tkn_admin

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.from.id.to_s
    when @admin_id
      case message.text
      when '/start'
        bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")

      when /activate\s\d{9}\s\d{1,3}/
        # Activates a pending instance for an user and gives a confirmation message 
        usr_id = BotControllers.splitter(message.text)[1]
        usr_instance = BotControllers.splitter(message.text)[2]
        participation = Participation.find(usr_instance)
        dashboard = Dashboard.find(participation.dashboard_id).includes(:participations)
        text = ''
        if participation.user_id == usr_id
          participation.update(active: true)
          text += "The instance #{usr_instance} of user #{usr_id} was activated\n"
          text += check_level_one(dashboard)
        else
          text += "The instance #{usr_instance} doesn't belong to user #{usr_id}. \nAction aborted."
        end
        bot.api.send_message(chat_id: message.chat.id, text: text)

      when /close\s\d{9}\s\d{1,3}/
        # Closes an instance for an user, creates a new lvl 1 active instance for the same kind of board and amount and gives a confirmation message 
        usr_id = BotControllers.splitter(message.text)[1]
        usr_instance = BotControllers.splitter(message.text)[2]
        participation = Participation.find(usr_instance).includes(:dashboard)
        text = ''
        if participation.user_id == usr_id
          if (participation.level == 4 && participation.dashboard.dashboard_type == 'long') || (participation.level == 3 && participation.dashboard.dashboard_type == 'short')
            participation.update(active: false)
            renewed_participation = Participation.create(user_id: usr_id, dashboard_id: participation.dashboard_id, level: 1, active: true)
            text += "The instance #{usr_instance} of user #{usr_id} has been closed and the instance #{renewed_participation.id} has been created"
          else
            text += "The level of instance #{usr_instance} is too low. \nAction aborted."
          end
        else
          text += "The instance #{usr_instance} doesn't belong to user #{usr_id}. \nAction aborted."
        end

        bot.api.send_message(chat_id: message.chat.id, text: text)

      when /delete\s\d{9}\s\d{1,3}/
        # Deletes a pending instance for an user and gives a confirmation message 
        usr_id = BotControllers.splitter(message.text)[1]
        usr_instance = BotControllers.splitter(message.text)[2]
        participation = Participation.find(usr_instance)
        text = ''
        if participation.user_id == usr_id
          participation.delete
          text += "The instance #{usr_instance} of user #{usr_id} was deleted"
        else
          text += "The instance #{usr_instance} doesn't belong to user #{usr_id}. \nAction aborted."
        end

        bot.api.send_message(chat_id: message.chat.id, text: text)

      when /check\sall/
        # Shows all the instances for all the users
        participations = Participation.all.includes(:dashboard).order(user_id: :asc)
        text = 'All participations:\n'
        participations.each do |participation|
          text += "User: #{participation.user_id}, Participation: #{participation.id}, Type: #{participation.dashboard.dashboard_type}, Entrance Fee: #{participation.dashboard.entrance_fee}, Level: #{participation.level}, Active: #{participation.active}\n"
        end
        bot.api.send_message(chat_id: message.chat.id, text: text)

      when /check\suser\s\d{9}/
        # Shows all the instances for a specific user
        user_id = BotControllers.splitter(message.text)[2]
        participations = Participation.where(user_id: user_id)
        text = "Participations of User #{user_id}:\n"
        participations.each do |participation|
          text += "Participation: #{participation.id}, Type: #{participation.dashboard.dashboard_type}, Entrance Fee: #{participation.dashboard.entrance_fee}, Level: #{participation.level}, Active: #{participation.active}\n"
        end
        bot.api.send_message(chat_id: message.chat.id, text: text)

      when /check\stype\s(long|short)/
        # Shows all the instances for a type of board, either long or short
        board_type = BotControllers.splitter(message.text)[2]
        dashboards = Dashboard.where(dashboard_type: board_type).includes(:participations)
        text = "Participations on #{board_type} dashboards:\n"
        dashboards.each do |dashboard|
          dashboard.participations.each do |participation|
            text += "User: #{participation.user_id}, Participation: #{participation.id}, Type: #{dashboard.dashboard_type}, Entrance Fee: #{dashboard.entrance_fee}, Level: #{participation.level}, Active: #{participation.active}\n"
          end
        end
        bot.api.send_message(chat_id: message.chat.id, text: text)

      when /check\slong\s(1|2|3|4)/
        # Shows all the instances of for long boards for a specific level from 1 to 4
        board_type = 'long'
        board_level = BotControllers.splitter(message.text)[2]
        dashboards = Dashboard.where(dashboard_type: board_type).includes(:participations)
        text = "Participations on level #{board_level} of #{board_type} dashboards:\n"
        dashboards.each do |dashboard|
          dashboard.participations.each do |participation|
            text += "User: #{participation.user_id}, Participation: #{participation.id}, Type: #{dashboard.dashboard_type}, Entrance Fee: #{dashboard.entrance_fee}, Level: #{participation.level}, Active: #{participation.active}\n" if participation.level == board_level
          end
        end
        bot.api.send_message(chat_id: message.chat.id, text: text)

      when /check\sshort\s(1|2|3)/
        # Shows all the instances of for short boards for a specific level from 1 to 3
        board_type = 'short'
        board_level = BotControllers.splitter(message.text)[2]
        dashboards = Dashboard.where(dashboard_type: board_type).includes(:participations)
        text = "Participations on level #{board_level} of #{board_type} dashboards:\n"
        dashboards.each do |dashboard|
          dashboard.participations.each do |participation|
            text += "User: #{participation.user_id}, Participation: #{participation.id}, Type: #{dashboard.dashboard_type}, Entrance Fee: #{dashboard.entrance_fee}, Level: #{participation.level}, Active: #{participation.active}\n" if participation.level == board_level
          end
        end
        bot.api.send_message(chat_id: message.chat.id, text: text)

      when /check\spending\s(long|short|all)/
        # Shows all the instances pending to be activated
        board_status = BotControllers.splitter(message.text)[2]
        participations = Participation.where(active: false).order(user_id: :asc).includes(:dashboard)
        text = "Pending participations:\n"
        participations.each do |participation|
          text += "User: #{participation.user_id}, Participation: #{participation.id}, Fee: #{participation.dashboard.entrance_fee}\n"
        end
        bot.api.send_message(chat_id: message.chat.id, text: text)

      when /check\sclosed/
        # Shows all the instances that have been closed
        participations = Participation.where(active: false, level: 4).order(user_id: :asc).includes(:dashboard)
        text = "Closed participations:\n"
        participations.each do |participation|
          text += "User: #{participation.user_id}, Participation: #{participation.id}, Fee: #{participation.dashboard.entrance_fee}, Type: #{participation.dashboard.dashboard_type}\n"
        end
        bot.api.send_message(chat_id: message.chat.id, text: text)

      else 
        bot.api.send_message(chat_id: message.chat.id, text: "I'm sorry, #{message.from.first_name}. I don't understand.")
      end
    else
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name} you are currently not authorized to use this bot")
    end
  end
end

def check_level_one(dashboard)
  participations = dashboard.participations.where(active: true).order(created_at: :desc)
  level_one = participations.where(level: 1)
  text = ''
  if dashboard.dashboard_type == 'long'
    if level_one.size == 8
      level_one.lock
      level_two = participations.where(level: 2).first(4).lock
      level_three = participations.where(level: 3).first(2).lock
      level_three.update_all(level: 4)
      level_two.update_all(level: 3)
      level_one.update_all(level: 2)
      text += "The following users need to be paid:\n"
      level_three.each do |participation|
        text += "User: #{participation.user_id}, Participation: #{participation.id}\n"
      end
    end
  else
    if level_one.size == 4
      level_one.lock
      level_two = participations.where(level: 2).first(2).lock
      level_two.update_all(level: 3)
      level_one.update_all(level: 2)
      text += "The following users need to be paid:\n"
      level_two.each do |participation|
        text += "User: #{participation.user_id}, Participation: #{participation.id}\n"
      end
    end
  end
  text
end