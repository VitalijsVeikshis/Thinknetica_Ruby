module Actions
  class MainActions < Action
    attr_reader :helper, :header

    def initialize(header)
      @header = header
      @helper = proc { Menu.new.main_menu }
    end

    def station(*)
      StationActions.new("#{@header}Station > ")
    end

    def route(*)
      RouteActions.new("#{@header}Route > ")
    end

    def train(*)
      TrainActions.new("#{@header}Train > ")
    end
  end
end
