class MenuListRequest

  DISHES = [
    {:dish => "Carbonara Pizza", :price => 11, :quantity => 0},
    {:dish => "Ragu Pizza", :price => 12.50, :quantity => 0},
    {:dish => "Calabrese Pizza", :price => 11.50, :quantity => 0},
    {:dish => "American Pizza", :price => 12.50, :quantity => 0},
    {:dish => "Fiorentina Pizza", :price => 12.50, :quantity => 0},
  ]

  def show(customer)
    DISHES.each { |dish|
      puts "- #{dish[:dish]}, £#{dish[:price]} \n\n"
     }
  end
end
