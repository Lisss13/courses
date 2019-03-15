require_relative 'console_interface/station_menu'
require_relative 'console_interface/route_menu'
require_relative 'console_interface/train_menu'

class Main
  def initialize
    @store = {
      routes: [],
      stations: [],
      train_cars: [],
      trains: []
    }
    @state_menu = StationMenu.new(self, @store)
    @route_menu = RouteMenu.new(self, @store)
    @train_menu = TrainMenu.new(self, @store)
  end

  def start
    puts 'Управление железнодорожным движением!'
    puts '1. Меню станций'
    puts '2. Меню маршрутов'
    puts '3. Меню поездов'
    puts '-----------'
    puts '0. Выход из программы'
    select
  end

  private

  def select
    select = gets.chomp.to_i
    case select
    when 1
      @state_menu.menu
    when 2
      @route_menu.menu
    when 3
      @train_menu.menu
    when 0
      abort('Выход!')
    else
      puts 'Ошибка ввода, выберите доступный вариант'
      puts '-----------'
      main
    end
  end
end

main = Main.new
main.start
