require 'telegram/bot'
require_relative('./values.rb')
# require_relative('./lib/bots_controller.rb')

token = @tkn
puts @launch

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    # Starts the boot and says hello to the user
    when '/start'
      @current = 0
      question = "#{@greeting} #{message.from.first_name} #{@instruction}"
      answers =
        Telegram::Bot::Types::ReplyKeyboardMarkup
        .new(keyboard: @kb_home , one_time_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: question, reply_markup: answers)

    when "#{@home}"
      @current = 0
      question = "#{@greeting} #{message.from.first_name} #{@instruction}"
      answers =
        Telegram::Bot::Types::ReplyKeyboardMarkup
        .new(keyboard: @kb_home, one_time_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: question, reply_markup: answers)
    
    # Section 1 Rules
    when "#{@sec1}"
      @current = 1
      question = @sec1_text
      answers =
        Telegram::Bot::Types::ReplyKeyboardMarkup
        .new(keyboard: @kb_home, one_time_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: question, reply_markup: answers)

    # Section 2 Check Status
    when "#{@sec2}"
      @current = 2
      question = @sec2
      answers =
        Telegram::Bot::Types::ReplyKeyboardMarkup
        .new(keyboard: @kb_home, one_time_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: question, reply_markup: answers)
    
    # Section 3 Volunteering
    when "#{@sec3}"
      @current = 3
      question = @sec3_text
      answers =
        Telegram::Bot::Types::ReplyKeyboardMarkup
        .new(keyboard: @kb_sec3, one_time_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: question, reply_markup: answers)
    
    when "#{@item_3_1}"
      @length = 'long'
      question = @item_3_1_text
      answers =
        Telegram::Bot::Types::ReplyKeyboardMarkup
        .new(keyboard: @kb_sec4, one_time_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: question, reply_markup: answers)

    when "#{@item_3_2}"
      @length = 'short'
      question = @item_3_2_text
      answers =
        Telegram::Bot::Types::ReplyKeyboardMarkup
        .new(keyboard: @kb_sec4, one_time_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: question, reply_markup: answers)

    # Section 4
    when "#{@sec4}"
      question = @sec4_text 
      answers =
        Telegram::Bot::Types::ReplyKeyboardMarkup
        .new(keyboard: @kb_sec4, one_time_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: question, reply_markup: answers)
    
    when "#{@item_4_1}"
      @size = '50'
      question = "You have selected #{@length} volunteering for #{@size} hours"
      answers =
        Telegram::Bot::Types::ReplyKeyboardMarkup
        .new(keyboard: @kb_sec5, one_time_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: question, reply_markup: answers)

    when "#{@item_4_2}"
      @size = '100'
      question = "You have selected #{@length} volunteering for #{@size} hours"
      answers =
        Telegram::Bot::Types::ReplyKeyboardMarkup
        .new(keyboard: @kb_sec5, one_time_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: question, reply_markup: answers)

    # Section 5
    when "#{@sec5}"
      @current = 5
      question = @instruction
      answers =
        Telegram::Bot::Types::ReplyKeyboardMarkup
        .new(keyboard: @kb_sec5, one_time_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: question, reply_markup: answers)
    
    when "#{@item_5_1}"
      question = @item_5_1_text
      answers =
        Telegram::Bot::Types::ReplyKeyboardMarkup
        .new(keyboard: @kb_answer, one_time_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: question, reply_markup: answers)

    when "#{@item_5_2}"
      question = @item_5_2_text
      answers =
        Telegram::Bot::Types::ReplyKeyboardMarkup
        .new(keyboard: @kb_answer, one_time_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: question, reply_markup: answers)

    #Section 6
    when "#{@sec6}" 
      @current = 6
      question = @instruction
      answers =
        Telegram::Bot::Types::ReplyKeyboardMarkup
        .new(keyboard: @kb_sec6, one_time_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: question, reply_markup: answers)
    
    when "#{@item_6_1}"
      question = @item_6_1_text
      answers =
        Telegram::Bot::Types::ReplyKeyboardMarkup
        .new(keyboard: @kb_answer, one_time_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: question, reply_markup: answers)

    # Section 7
    when "#{@sec7}"
      @current = 7
      question = @instruction
      answers =
        Telegram::Bot::Types::ReplyKeyboardMarkup
        .new(keyboard: @kb_home, one_time_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: question, reply_markup: answers)

    # Stops the Bot and says goodbye
    when "#{@end}"
      @current = 0
      kb = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: "#{@goodbye} #{message.from.first_name} \n #{@restart}", reply_markup: kb)
    end
  end
end
