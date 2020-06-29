class HomeController < ApplicationController
  def welcome
    @houses = House.order('created_at DESC').first(6)
    @complex_buildings = ComplexBuilding.order('created_at DESC').first(6)
    @commercial_units = CommercialUnit.order('created_at DESC').first(6)
  end
end
