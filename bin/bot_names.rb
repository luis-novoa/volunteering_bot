require 'telegram/bot'
require_relative('./values.rb')
require_relative('../lib/controllers/bots_controllers.rb')
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

        bot.api.send_message(chat_id: message.chat.id, text: "The instance #{usr_instance} of user #{usr_id} was activated")

      when /close\s\d{9}\s\d{1,3}/
        # Closes an instance for an user, creates a new lvl 1 active instance for the same kind of board and amount and gives a confirmation message 
        usr_id = BotControllers.splitter(message.text)[1]
        usr_instance = BotControllers.splitter(message.text)[2]
        # This is solely for the purpose of mock interfacing
        new_instance = usr_instance.to_i + 1

        bot.api.send_message(chat_id: message.chat.id, text: "The instance #{usr_instance} of user #{usr_id} was has been closed and the instance #{new_instance.to_s} has been created")

      when /delete\s\d{9}\s\d{1,3}/
        # Deletes a pending instance for an user and gives a confirmation message 
        usr_id = BotControllers.splitter(message.text)[1]
        usr_instance = BotControllers.splitter(message.text)[2]

        bot.api.send_message(chat_id: message.chat.id, text: "The instance #{usr_instance} of user #{usr_id} was deleted")

      when /check\sall/
        # Shows all the instances for all the users
        bot.api.send_message(chat_id: message.chat.id, text: "All was checked")

      when /check\suser\s\d{9}/
        # Shows all the instances for a specific user
        user_id = BotControllers.splitter(message.text)[2]

        bot.api.send_message(chat_id: message.chat.id, text: "The user #{usr_id} was checked")

      when /check\stype\s(long|short)/
        # Shows all the instances for a type of board, either long or short
        board_type = BotControllers.splitter(message.text)[2]

        bot.api.send_message(chat_id: message.chat.id, text: "All #{board_type} boards were checked")

      when /check\slong\s(1|2|3|4)/
        # Shows all the instances of for long boards for a specific level from 1 to 4
        board_type = 'long'
        board_level = BotControllers.splitter(message.text)[2]

        bot.api.send_message(chat_id: message.chat.id, text: "All users at long boards level #{board_level} were checked")

      when /check\sshort\s(1|2|3)/
        # Shows all the instances of for short boards for a specific level from 1 to 3
        board_type = 'short'
        board_level = BotControllers.splitter(message.text)[2]

        bot.api.send_message(chat_id: message.chat.id, text: "All users at short board level #{board_level} were checked")

      when /check\spending\s(long|short|all)/
        # Shows all the instances pending to be activated
        board_status = BotControllers.splitter(message.text)[2]

        bot.api.send_message(chat_id: message.chat.id, text: "These are all the pending users in #{board_status} boards")

      when /check\sclosed/
        # Shows all the instances that have been closed
        bot.api.send_message(chat_id: message.chat.id, text: "These are all the closed users")

      else 
        bot.api.send_message(chat_id: message.chat.id, text: "I'm sorry, #{message.from.first_name}. I don't understand.")
      end
    else
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name} you are currently not authorized to use this bot")
    end
  end
end
