module Actions
  class RouteSelectActions < Action
    attr_reader :helper, :header

    def initialize(header, route)
      @header = "#{header}#{route.id} > "
      @helper = proc { Menu.new.route_menu }
      @route = route
    end

    def add(name)
      @route.add_station(Station.find(name.shift))
    end

    def delete(name)
      @route.delete_station(Station.find(name.shift))
    end

    def info(*)
      puts 'Stations'
      @route.stations.each { |station| puts station.id }
    end
  end
end
