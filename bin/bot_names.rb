require 'telegram/bot'
require_relative('./values.rb')
require_relative('./lib/bots_controller.rb')
token = @tkn_admin

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")

    when /activate\s\d{9}\s\d{1,3}/
      # Activates a pending instance for an user and gives a confirmation message 
      usr_id = splitter(message.from.id)[1]
      usr_instance = splitter(message.from.id)[2]

      bot.api.send_message(chat_id: message.chat.id, text: "output goes here")

    when /delete\s\d{9}\s\d{1,3}/
      # Deletes a pending instance for an user and gives a confirmation message 
      usr_id = splitter(message.from.id)[1]
      usr_instance = splitter(message.from.id)[2]

      bot.api.send_message(chat_id: message.chat.id, text: "output goes here")

    when /check\sall/
      # Shows all the instances for all the users
      bot.api.send_message(chat_id: message.chat.id, text: "output goes here")

    when /check\suser\s\d{9}/
      # Shows all the instances for a specific user
      user_id = splitter(message.from.id)[2]

      bot.api.send_message(chat_id: message.chat.id, text: "output goes here")

    when /check\stype\s(long|short)/
      # Shows all the instances for a type of board, either long or short
      board_type = splitter(message.from.id)[2]

      bot.api.send_message(chat_id: message.chat.id, text: "output goes here")

    when /check\stype\slong\s(1|2|3|4)/
      # Shows all the instances of for long boards for a specific level from 1 to 4
      board_type = 'long'
      board_level = board_type = splitter(message.from.id)[3]

      bot.api.send_message(chat_id: message.chat.id, text: "output goes here")

    when /check\stype\sshort\s(1|2|3)/
      # Shows all the instances of for short boards for a specific level from 1 to 3
      board_type = 'short'
      board_level = board_type = splitter(message.from.id)[3]

      bot.api.send_message(chat_id: message.chat.id, text: "output goes here")

    when /check\spending\s(long|short|all)/
      # Shows all the instances pending to be activated
      board_type = splitter(message.from.id)[2]

      bot.api.send_message(chat_id: message.chat.id, text: "output goes here")

    when /check\sclosed/
      # Shows all the instances that have been closed
      bot.api.send_message(chat_id: message.chat.id, text: "output goes here")

    else 
      bot.api.send_message(chat_id: message.chat.id, text: "I'm sorry, #{message.from.first_name}. I don't understand.")
    end
  end
end
