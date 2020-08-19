# Selects to which section to return

def self.returning(current)
  @section = current
  case @section
  when @section = 1
    return @kb_sec1

  when @section = 2
    return @kb_sec2

  when @section = 3
    return @kb_sec3

  when @section = 4
    return @kb_sec4

  when @section = 5
    return @kb_sec5

  when @section = 6
    return @kb_sec6

  when @section = 7
    return @kb_sec7
  end
end