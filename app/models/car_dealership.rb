require 'dry/monads'

class CarDealership
  include Dry::Monads[:result, :do]

  def initialize
    @available_models = %w[Avalon Camry Corolla Venza]
    @available_colors = %w[red black blue white]
    @nearby_cities = %w[Austin Chicago Seattle]
  end

  def deliver_car(year, model, color, city)
    yield check_year(year)
    yield check_model(model)
    yield check_city(city)
    yield check_color(color)

    Success("A #{color} #{year} Toyota #{model} will be delivered to #{city}")
  end

  def check_year(year)
    year < 2000 ? Failure("We have no cars manufactured in year #{year}") : Success('Cars of this year are available')
  end

  def check_model(model)
    @available_models.include?(model) ? Success('Model available') : Failure('The model requested is unavailable')
  end

  def check_color(color)
    @available_colors.include?(color) ? Success('This color is available') : Failure("Color #{color} is unavailable")
  end

  def check_city(city)
    @nearby_cities.include?(city) ? Success("Car deliverable to #{city}") : Failure('Apologies, we cannot deliver to this city')
  end
end

good_dealer = CarDealership.new
puts good_dealer.deliver_car(1990, 'Venza', 'red', 'Austin')
puts good_dealer.deliver_car(2005, 'Rav4', 'red', 'Austin')
puts good_dealer.deliver_car(2015, 'Venza', 'yellow', 'Austin')
puts good_dealer.deliver_car(2000, 'Venza', 'red', 'Surrey')
puts good_dealer.deliver_car(2000, 'Avalon', 'blue', 'Austin')
