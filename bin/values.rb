# The Telegram bot's token goes here, replace 'token' for your token, keep the quotation marks as in 'your-token-goes-here'
@tkn = '877177203:AAE5tNPbYDt62BTzlWxG02FzYhe6uqQHu88'

# The values for each section go here, keep the quotation marks

  # Section 0
  @greeting = "Hello, "
  @instruction = 'please, choose an option'
  @goodbye = 'Goodbye,'
  @restart = "To restart the Bot please type /start"
  @current = 0

  # This message is shown in the terminal when the bot is launched
  @launch = 'Bot up and running!'

  # Section 1 - Rules
  @sec1 = 'Rules'

  # Section 1 text
  @sec1_text = 'Explanation of Rules goes here'


  # Section 2 - Check Status
  @sec2 = 'Check Status'

  # Section 2 text
  @sec2_text = 'Your current participation is this'

  # Section 3 - Volunteering
  @sec3 = 'Volunteer'

  # Section 3 text
  @sec3_text = 'Please, choose the length of your volunteering'

  # Section 3 @items

  @item_3_1 = 'Volunteer Long'
  @item_3_1_text = 'You have selected long volunteering'

  @item_3_2 = 'Volunteer Short'
  @item_3_2_text = 'you have selected short volunteering'


  # Section 4 - Volunteering Amount
  @sec4 = 'Volunteering Amount'

  # Section 4 text
  @sec4_text = 'Please, choose how many hours to volunteer'

  # Section 4 @items

  @item_4_1 = '50'
  @item_4_1_text = "You have selected #{@length} volunteering for 50 hours"

  @item_4_2 = '100'
  @item_4_2_text = "You have selected #{@length} volunteering for 100 hours"

  # Section 5 - Confirmation
  @sec5 = 'Volunteering Amount'

  # Section 5 text
  @sec_5_text = 'Please, confirm your volunteering'

  # Section 5 @items

  @item_5_1 = 'Confirm'
  @item_5_1_text = 'Confirm'

  @item_5_2 = 'Cancel'
  @item_5_2_text = 'Volunteering has been cancelled'

    # Section 6 - Proof of Payment
    @sec6 = 'Send proof of payment'

    # Section 6 text
    @sec_6_text = 'Please, send a screenshot of your payment'
  
    # Section 6 @items
  
    @item_6_1 = 'Send proof of payment'
    @item_6_1_text = 'Thank you for sending your proof of payment, it will be reviewed and you will be notified once it has been approved'


  # Section 7 - Help
  @sec7 = 'Help'

  # Section 7 text
  @sec_7_text = 'An administrator will get in touch soon'
  

  # Keyboard Variables
  @home = 'Home'
  @return = 'Back'
  @end = 'Exit'

  # Keyboards

  @kb_home = [
    [@sec1],
    [@sec2], 
    [@sec3],
    [@sec7]
  ]

  @kb_answer = [@home, @return, @end]


  @kb_sec3 = [
    [@item_3_1],
    [@item_3_2],
    [@home, @end]
  ]

  @kb_sec4 = [
    [@item_4_1],
    [@item_4_2],
    [@home, @end]
  ]

  @kb_sec5 = [
    [@item_5_1],
    [@item_5_2],
  ]

  @kb_sec6 = [
    [@item_6_1]
  ]

  @kb_sec7 = [
    [@home, @end]
  ]
