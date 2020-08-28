# returns a boolean value based on wether the input matches de format "command id instance" as in "activate 1234567890 123"
def match_activate(str)
  !!(str =~ /activate\s\d{9}\s\d{1,3}/)
end

# returns a boolean value based on wether the input matches de format "command id instance" as in "delete 1234567890 123"
def match_delete(str)
  !!(str =~ /delete\s\d{9}\s\d{1,3}/)
end

# returns a boolean value based on wether the input matches de format "check all" 
def match_check_all(str)
  !!(str =~ /check\sall/)
end

# returns a boolean value based on wether the input matches de format "check user id" as in "cher user 1234567890" 
def match_check_user(str)
  !!(str =~ /check\suser\s\d{9}/)
end

# returns a boolean value based on wether the input matches de format "check type long/short" as in "check type long"
def match_check_type(str)
  !!(str =~ /check\stype\s(long|short)/)
end

# returns a boolean value based on wether the input matches de format "check type long level" as in "check type long 4"
def match_check_long_level(str)
  !!(str =~ /check\stype\slong\s(1|2|3|4)/)
end

# returns a boolean value based on wether the input matches de format "check type short level" as in "check type short 3"
def match_check_short_level(str)
  !!(str =~ /check\stype\sshort\s(1|2|3)/)
end

# returns a boolean value based on wether the input matches de format "check pending long/short/all" as in "check pending all"
def match_pending(str)
  !!(str =~ /check\spending\s(long|short|all)/)
end

# returns a boolean value based on wether the input matches de format "check closed"
def match_closed(str)
  !!(str =~ /check\sclosed/)
end

# Returns an array of strings where 0 is the command, 1 is the id and 2 is the instance.
def splitter(str)
  str.scan(/\w+/)
end

# returns the command as a string
def command_extractor(str)
  splitter(str)[0]
end

# returns the id as a string
def id_extractor(str)
  splitter(str)[1]
end

# returns the instance as a string
def instance_extractor(str)
  splitter(str)[2]
end

# universal extractor, takes a string parameter that is evaluated to define the index of what to extract
def universal_extractor(str, parameter)
  case parameter
  when 'command'
    index = 0
  when 'id'
    index = 1
  when 'instance'
    index = 2
  end
  splitter(str)[index]
end