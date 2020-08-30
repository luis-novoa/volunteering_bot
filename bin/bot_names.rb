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
          check_level_one(dashboard)
          text += "The instance #{usr_instance} of user #{usr_id} was activated"
        else
          text += "The instance #{usr_instance} doesn't belong to user #{usr_id}. Action aborted."
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
          text += "The instance #{usr_instance} doesn't belong to user #{usr_id}. Action aborted."
        end

        bot.api.send_message(chat_id: message.chat.id, text: text)

      when /check\sall/
        # Shows all the instances for all the users
        participations = Participation.all
        bot.api.send_message(chat_id: message.chat.id, text: "All was checked")

      when /check\suser\s\d{9}/
        # Shows all the instances for a specific user
        user_id = BotControllers.splitter(message.text)[2]
        participations = Participation.where(user_id: user_id)
        bot.api.send_message(chat_id: message.chat.id, text: "The user #{usr_id} was checked")

      when /check\stype\s(long|short)/
        # Shows all the instances for a type of board, either long or short
        board_type = BotControllers.splitter(message.text)[2]
        dashboards = Dashboard.where(type: board_type).includes(:participations)
        participations = []
        dashboards.each do |dashboard|
          dashboard.participations.each do |participation|
            participations << participation
          end
        end
        bot.api.send_message(chat_id: message.chat.id, text: "All #{board_type} boards were checked")

      when /check\slong\s(1|2|3|4)/
        # Shows all the instances of for long boards for a specific level from 1 to 4
        board_type = 'long'
        board_level = BotControllers.splitter(message.text)[2]
        dashboards = Dashboard.where(type: board_type).includes(:participations)
        participations = []
        dashboards.each do |dashboard|
          dashboard.participations.each do |participation|
            participations << participation if participation.level == board_level
          end
        end
        bot.api.send_message(chat_id: message.chat.id, text: "All users at long boards level #{board_level} were checked")

      when /check\sshort\s(1|2|3)/
        # Shows all the instances of for short boards for a specific level from 1 to 3
        board_type = 'short'
        board_level = BotControllers.splitter(message.text)[2]
        dashboards = Dashboard.where(type: board_type).includes(:participations)
        participations = []
        dashboards.each do |dashboard|
          dashboard.participations.each do |participation|
            participations << participation if participation.level == board_level
          end
        end
        bot.api.send_message(chat_id: message.chat.id, text: "All users at short board level #{board_level} were checked")

      when /check\spending\s(long|short|all)/
        # Shows all the instances pending to be activated
        board_status = BotControllers.splitter(message.text)[2]
        participations = Participation.where(active: false)
        bot.api.send_message(chat_id: message.chat.id, text: "These are all the pending users in #{board_status} boards")

      when /check\sclosed/
        # Shows all the instances that have been closed
        bot.api.send_message(chat_id: message.chat.id, text: "These are all the closed users")

      else 
        bot.api.send_message(chat_id: message.chat.id, text: "I'm sorry, #{message.from.first_name}. I don't understand.")
      end
    else
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name} you are not currently authorized to use this bot")
    end
  end
end

def check_level_one(dashboard)
  participations = dashboard.participations.where(active: true).order(created_at: :desc)
  level_one = participations.where(level: 1)
  if dashboard.type == 'long'
    if level_one.size == 8
      level_one.lock
      level_two = participations.where(level: 2).first(4).lock
      level_three = participations.where(level: 3).first(2).lock
      level_three.update_all(level: 4)
      level_two.update_all(level: 3)
      level_one.update_all(level: 2)
    end
  else
    if level_one.size == 4
      level_one.lock
      level_two = participations.where(level: 2).first(2).lock
      level_two.update_all(level: 3)
      level_one.update_all(level: 2)
  end
end