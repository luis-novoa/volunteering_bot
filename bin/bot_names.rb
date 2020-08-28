require 'telegram/bot'
require_relative('./values.rb')
require_relative('./lib/bots_controller.rb')
token = @tkn_admin

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")

    when /activate\s\d{10}\s\d{1,3}/

      usr_id = splitter(message.from.id)[1]
      usr_instance = splitter(message.from.id)[2]

      bot.api.send_message(chat_id: message.chat.id, text: "")

    when /check\sall/

      bot.api.send_message(chat_id: message.chat.id, text: "")

    when /check\suser\s\d{10}/

      user_id = splitter(message.from.id)[2]

      bot.api.send_message(chat_id: message.chat.id, text: "")

    when /check\stype\s(long|short)/

      board_type = splitter(message.from.id)[2]

      bot.api.send_message(chat_id: message.chat.id, text: "")

    when /check\stype\slong\s(1|2|3|4)/

      board_type = 'long'
      board_level = board_type = splitter(message.from.id)[3]

      bot.api.send_message(chat_id: message.chat.id, text: "")

    when /check\stype\sshort\s(1|2|3)/

      board_type = 'short'
      board_level = board_type = splitter(message.from.id)[3]

      bot.api.send_message(chat_id: message.chat.id, text: "")

    when /check\spending\s(long|short|all)/

      board_type = splitter(message.from.id)[2]

      bot.api.send_message(chat_id: message.chat.id, text: "")

    when /check\sclosed/

      bot.api.send_message(chat_id: message.chat.id, text: "")

    else 
      bot.api.send_message(chat_id: message.chat.id, text: "I'm sorry, #{message.from.first_name}. I don't understand.")
    end
  end
end
