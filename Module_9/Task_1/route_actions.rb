module Actions
  class RouteActions < Action
    include Actions

    def initialize(header)
      @header = header
      @helper = proc { Menu.new.route_menu }
      @actions = actions_list
    end

    private

    def actions_list
      {
        add: proc { |params| add(params) },
        select: proc do |params|
          RouteSelectActions.new(@header, select_item(params)).run
        end,
        all: proc { all }
      }
    end

    def add(stations)
      Route.new(initial: Station.find(stations.shift),
                terminal: Station.find(stations.shift))
    end

    def select_item(route)
      Route.find(route.shift.to_i)
    end

    def all
      puts 'Stations'.ljust(10) + 'Route name'
      Route.all.each { |route| puts route.id.to_s.ljust(10) + route.name.to_s }
    end
  end
end
