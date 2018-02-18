require_relative 'station'
require_relative 'route'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'cargo_carriage'
require_relative 'passenger_carriage'
require_relative 'menu'
require_relative 'actions'
require_relative 'action'

class Simulation < Action
  include Actions

  def initialize(header)
    @header = header
    @helper = proc { Menu.new.main_menu }
    @actions = actions_list
  end

  private

  def actions_list
    {
      station: proc { StationActions.new("#{@header}Station > ").run },
      route: proc { RouteActions.new("#{@header}Route > ").run },
      train: proc { TrainActions.new("#{@header}Train > ").run }
    }
  end
end
