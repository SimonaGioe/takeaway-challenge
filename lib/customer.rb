require_relative 'menu_list_request'
require_relative 'order'

class Customer
  attr_reader :name, :selection

  def initialize
    @selection = []
  end

  def add_to_order(dish, quantity)
    if @order == nil
      @order = Order.new
    end
    @order.selected(dish, quantity)
    @order.selected_dishes.each {|dish_selected| @selection << dish_selected }
  end

  def complete_order
    @order.complete
  end
end
