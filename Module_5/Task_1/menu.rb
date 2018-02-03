TAB1 = 10
TAB2 = 34

class Menu
  
  def main_menu
    station_menu
    route_menu
    train_menu
    puts 'exit'.rjust(TAB1)
  end

  def station_menu
    print 'station '.rjust(TAB1)
    puts '> add <name>'
    print ''.rjust(TAB1)
    puts '> report <name>'
    print ''.rjust(TAB1)
    puts '> all'
    print ''.rjust(TAB1)
    puts '< exit'
  end

  def route_menu
    print 'route '.rjust(TAB1)
    puts '> add <initial_station> <terminal_station>'
    print ''.rjust(TAB1)
    puts '> select <route number> > add <station_number>'
    print ''.rjust(TAB2)
    puts '> delete <station_number>'
    print ''.rjust(TAB2)
    puts '> info'
    print ''.rjust(TAB2)
    puts '< exit'
    print ''.rjust(TAB1)
    puts '> all'
    print ''.rjust(TAB1)
    puts '< exit'
  end

  def train_menu
    print 'train '.rjust(TAB1)
    puts '> add <passenger/cargo> <speed> <route_number>'
    print ''.rjust(TAB1)
    puts '> select <train_number> > connect <passenger/cargo>'
    print ''.rjust(TAB2)
    puts '> disconnect'
    print ''.rjust(TAB2)
    puts '> forward'
    print ''.rjust(TAB2)
    puts '> back'
    print ''.rjust(TAB2)
    puts '> assign <route_number>'
    print ''.rjust(TAB2)
    puts '< exit'
    print ''.rjust(TAB1)
    puts '> all'
    print ''.rjust(TAB1)
    puts '< exit'
  end
end
