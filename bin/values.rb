# The Telegram bot's token goes here, replace 'token' for your token, keep the quotation marks as in 'your-token-goes-here'
@tkn_public = '877177203:AAE5tNPbYDt62BTzlWxG02FzYhe6uqQHu88'
@tkn_admin = '1118059983:AAHGhd2BhPa78F_zaw0BbSrWceBqVHfILPE'
@admin_id = '748866554'

@verb = 'volunteer'
@verbing = 'volunteering'
@pasted = "volunteered"
@image1 = 'https://i.ibb.co/KKJm82J/bot1.jpg'
@image2 = 'https://i.ibb.co/Jm4Mwyb/bot2.jpg'

# The values for each section go here, keep the quotation marks

  # Section 0
  @greeting = "Hello "
  @instruction = '! Please, choose an option'
  @goodbye = 'Goodbye,'
  @restart = "To restart the Bot please type /start"
  @current = 0

  # This message is shown in the terminal when the bot is launched
  @launch = 'Bot up and running!'

  # Section 1 - Rules
  @sec1 = 'Rules'

  # Section 1 text
  @sec1_text = "
  Welcome to the fast #{@verbing} bot!
  \nThe you will be presented with several options for you to participate in #{@verbing} boards, either express ones with 3 levels, or traditional ones with 4.
  \nThe working of the boards is as in a standard SuSu, as shown in the diagrams bellow.
  \nIn order to make this more dynamic and avoid stagnant boards, there are no fixed boards, every time a new user is confirmed for a tier one position, the algorithm will
  see if the conditions to form a board are met, and if so, a board will be created, users will advance a tier, and the user in the center will be #{@pasted}.
  \nIn our model, participating again is mandatory, so the amount for another #{verbing} will be kept, and another tier 1 participation will be activated for the same kind of board and amount as the previous one.
  \nA mantainance amount will be retained as well.
  \n\nIn order do participate:
  \n1 Select the #{@verb} option.
  \n2 Select the kind of board
  \n3 Select the amount
  \n4 Confirm your participation
  \n5 Contact your administrator to send proof of your #{verbing} so it can be activated along with your ID.
  \n\nYou can see your ID using the Check Status option, where you can also see the status of all your active and pending participations.
  \n\nIn case you need help, select the Help option, which will notify the administrator that you need help so you can be contacted ASAP.
  \nMake sure your Telegram account has an username as in @yourusername, if it doesn't, contact your administrator directly.
  "

  # Section 2 - Check Status
  @sec2 = 'Check Status'

  # Section 2 text
  @sec2_text = 'Your current participation is this'

  # Section 3 - Volunteering
  @sec3 = "#{@verb}"

  # Section 3 text
  @sec3_text = "Please, choose the length of your #{@conjugated}"

  # Section 3 @items

  @item_3_1 = 'Long, 4 levels'

  @item_3_2 = 'Short, 3 levels'

  # Section 4 - Volunteering Amount
  @sec4 = "#{@conjugated} Amount"

  # Section 4 text
  @sec4_text = "Please, choose how many hours to #{@verb}"

  # Section 4 @items

  @item_4_1 = '50'
  @item_4_1_text = "You have selected #{@length} #{@conjugated} for 50 hours"

  @item_4_2 = '100'
  @item_4_2_text = "You have selected #{@length} #{@conjugated} for 100 hours"

  # Section 5 - Confirmation
  @sec5 = "#{@conjugated} Amount"

  # Section 5 text
  @sec_5_text = "Please, confirm your #{@conjugated}"

  # Section 5 @items

  @item_5_1 = 'Confirm'
  @item_5_1_text = 'Your request has been successfully confirmed'

  @item_5_2 = 'Cancel'
  @item_5_2_text = 'Your request has been cancelled'

  # Section 6 - Help
  @sec6 = 'Help'

  # Section 6 text
  @sec6_text = 'The administrator has been notified about your help request and will get in touch as soon as posible. \n If your account does not have an username, please contact the administrator directly'
  
  # Keyboard Variables
  @home = 'Home'
  @return = 'Back'
  @end = 'Exit'

  # Keyboards

  @kb_home = [
    [@sec1],
    [@sec2], 
    [@sec3],
    [@sec6]
  ]

  @kb_sec3 = [
    [@item_3_1],
    [@item_3_2]
  ]

  @kb_sec4 = [
    [@item_4_1],
    [@item_4_2]
  ]

  @kb_sec5 = [
    [@item_5_1],
    [@item_5_2],
  ]
