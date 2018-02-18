TAB1 = 11
TAB2 = 35
ALL = [
  '> all',
  '< exit'
].freeze
INFO = [
  '> info',
  '< exit'
].freeze
STATION = [
  '> add <name>',
  '> report <name>'
].freeze
ROUTE = [
  '> add <initial_station> <terminal_station>',
  '> select <route number> > add <station_name>'
].freeze
ROUTE_SELECT = [
  '> delete <station_number>'
].freeze
TRAIN = [
  '> add <passenger/cargo> <train_number> <speed> <route_number>',
  '> select <train_number> > connect <passenger/cargo> <capacity>'
].freeze
TRAIN_SELECT = [
  '> disconnect',
  '> fill <carriage_number> <amount>',
  '> forward', '> back',
  '> assign <route_number>'
].freeze

class Menu
  class SubMenu
    def initialize(options)
      @head = options[:head]
      @indent = options[:indent]
      @items = options[:items]
    end

    def make(string, indent, indent_string = '')
      indent_string.rjust(indent) + string
    end

    def show
      puts make(@items.first, @indent, @head)
      @items[1..-1].each { |item| puts make(item, @indent) }
    end
  end

  def initialize
    @menu_items = {
      all: SubMenu.new(head: '', indent: TAB1, items: ALL),
      info: SubMenu.new(head: '', indent: TAB2, items: INFO),
      station: SubMenu.new(head: 'station ', indent: TAB1, items: STATION),
      route: SubMenu.new(head: 'route ', indent: TAB1, items: ROUTE),
      route_select: SubMenu.new(head: '', indent: TAB2, items: ROUTE_SELECT),
      train: SubMenu.new(head: 'train ', indent: TAB1, items: TRAIN),
      train_select: SubMenu.new(head: '', indent: TAB2, items: TRAIN_SELECT)
    }
  end

  def main_menu
    station_menu
    route_menu
    train_menu
    puts 'exit'.rjust(TAB1)
  end

  def station_menu
    @menu_items[:station].show
    @menu_items[:all].show
  end

  def route_menu
    @menu_items[:route].show
    route_select_menu
    @menu_items[:all].show
  end

  def route_select_menu
    @menu_items[:route_select].show
    @menu_items[:info].show
  end

  def train_menu
    @menu_items[:train].show
    train_select_menu
    @menu_items[:all].show
  end

  def train_select_menu
    @menu_items[:train_select].show
    @menu_items[:info].show
  end
end
