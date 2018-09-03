require_relative 'console_interface/station_menu'
require_relative 'console_interface/route_menu'
require_relative 'console_interface/train_menu'

class Main
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
        StationMenu.new(self)
      when 2
        RouteMenu.new(self)
      when 3
        TrainMenu.new(self)
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