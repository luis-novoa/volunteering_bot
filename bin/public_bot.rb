require 'telegram/bot'
require_relative('./values.rb')
require_relative('../lib/controllers/bots_controllers.rb')
require File.expand_path('../lib/models/participation', __dir__)
require File.expand_path('../lib/models/dashboard', __dir__)

token = @tkn_public
puts @launch

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    @identity = message.from.id
    case message.text
    # Starts the boot and says hello to the user
    when '/start'
      question = "#{@greeting} #{message.from.first_name} #{@instruction}"
      answers =
        Telegram::Bot::Types::ReplyKeyboardMarkup
        .new(keyboard: @kb_home , one_time_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: question, reply_markup: answers)

    when "#{@home}"
      question = "#{@greeting} #{message.from.first_name} #{@instruction}"
      answers =
        Telegram::Bot::Types::ReplyKeyboardMarkup
        .new(keyboard: @kb_home, one_time_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: question, reply_markup: answers)
    
    # Section 1 Rules
    when "#{@sec1}"
      question = @sec1_text
      answers =
        Telegram::Bot::Types::ReplyKeyboardMarkup
        .new(keyboard: @kb_home, one_time_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: question, reply_markup: answers)

    # Section 2 Check Status
    when "#{@sec2}"
      #Here is where the output goes here, and it should show all the instances for the user, both active and pending. if you want I can create a method to format the output nicely.
      # you can find the user id in @identity
      question = "Your ID is #{message.from.id}\n#{@sec2_text}"
      answers =
        Telegram::Bot::Types::ReplyKeyboardMarkup
        .new(keyboard: @kb_home, one_time_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: question, reply_markup: answers)
      user_participations = Participation.where(id: @identity).includes(:dashboard)
      if user_participations.size.zero?
        bot.api.send_message(chat_id: message.chat.id, text: "User #{@identity} isn't participating in any board")
      else
        text = ""
        user_participations.each do |participation|
          text += "Participation ID: #{participation.id}, Type: #{participation.dashboard.type}, Entrance Fee: #{participation.dashboard.entrance_fee}, Level: #{participation.level}\n"
        end
        bot.api.send_message(chat_id: message.chat.id, text: text)
      end
    
    # Section 3 Volunteering
    when "#{@sec3}"
      question = @sec3_text
      answers =
        Telegram::Bot::Types::ReplyKeyboardMarkup
        .new(keyboard: @kb_sec3, one_time_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: question, reply_markup: answers)
    
    when "#{@item_3_1}"
      @length = 'long'
      question = "You have selected #{@length} volunteering. \nPlease, choose how many hours you want to volunteer"
      answers =
        Telegram::Bot::Types::ReplyKeyboardMarkup
        .new(keyboard: @kb_sec4, one_time_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: question, reply_markup: answers)

    when "#{@item_3_2}"
      @length = 'short'
      question = "you have selected #{@length} volunteering \nPlease, choose how many hours you want to volunteer"
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

    # Section 5 Confirmation
    
    when "#{@item_5_1}"
      question = @item_5_1_text
      answers =
        Telegram::Bot::Types::ReplyKeyboardMarkup
        .new(keyboard: @kb_home, one_time_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: question, reply_markup: answers)
      # Here we have the type of board stored in the variable @length and the amount in @size
      # It should be able to create a new instance for that user based on those two parameters
      # aditionally, the user's unique id is found in @identity
      dashboard = Dashboard.find_by(type: @length, entrance_fee: @size)
      if dashboard.participations.where(user_id: @identity, active: true).zero?
        dashboard.participations.build(user_id: @identity, level: 1, active: false)
        dashboard.save
        bot.api.send_message(chat_id: message.chat.id, text: "Your participation request was created. Please, pay the fee and notify the administrator.")
      else
        bot.api.send_message(chat_id: message.chat.id, text: "You already participate on this dashboard! Please select another one.")
      end

    when "#{@item_5_2}"
      question = @item_5_2_text
      answers =
        Telegram::Bot::Types::ReplyKeyboardMarkup
        .new(keyboard: @kb_home, one_time_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: question, reply_markup: answers)

    # Section 6
    when "#{@sec6}"
      question = @sec6_text
      answers =
        Telegram::Bot::Types::ReplyKeyboardMarkup
        .new(keyboard: @kb_home, one_time_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: question, reply_markup: answers)

    # Stops the Bot and says goodbye
    when "#{@end}"
      kb = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true)
      bot.api.send_message(chat_id: message.chat.id, text: "#{@goodbye} #{message.from.first_name} \n #{@restart}", reply_markup: kb)
    end
  end
end
