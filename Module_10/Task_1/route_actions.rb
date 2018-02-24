module Actions
  class RouteActions < Action
    attr_reader :helper, :header

    def initialize(header)
      @header = header
      @helper = proc { Menu.new.route_menu }
    end

    def add(stations)
      Route.new(initial: Station.find(stations.shift),
                terminal: Station.find(stations.shift))
    end

    def chose(route)
      RouteSelectActions.new(@header, Route.find(route.shift.to_i))
    end

    def all(*)
      puts 'Stations'.ljust(10) + 'Route name'
      Route.all.each { |route| puts route.id.to_s.ljust(10) + route.name.to_s }
    end
  end
end
