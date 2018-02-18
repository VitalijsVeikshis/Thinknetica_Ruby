module Actions
  class RouteSelectActions < Action
    include Actions

    def initialize(header, route)
      @header = "#{header}#{route.id} > "
      @helper = proc { Menu.new.route_menu }
      @route = route
      @actions = actions_list
    end

    private

    def actions_list
      {
        add: proc { |params| add(params) },
        delete: proc { |params| delete(params) },
        info: proc { info }
      }
    end

    def add(name)
      @route.add_station(Station.find(name.shift))
    end

    def delete(name)
      @route.delete_station(Station.find(name.shift))
    end

    def info
      puts 'Stations'
      @route.stations.each { |station| puts station.id }
    end
  end
end
