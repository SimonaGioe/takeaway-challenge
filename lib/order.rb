require_relative "menu_list_request"
require 'rubygems'
require 'twilio-ruby'
require 'pry'

class Order

  attr_reader :selected_dishes, :order_message_sid

  def initialize
    @selected_dishes = []
    @order_message_sid = []
  end

  def selected(dish, quantity)
    if not_started
      start
    end
    if included_in_order(dish)
      update_existing_quantity_selected(dish, quantity)
      see_current_selection
    elsif included_in_menu(dish)
      add_to_order(dish, quantity)
      see_current_selection
    else
      raise "Dish not included in the menu"
    end
  end

  def complete
    see_current_selection
    send_message

  end

  private

  def start
    @selected_dishes = []
  end

  def not_started
    @selected_dishes.empty?
  end

  def see_current_selection
    @selected_dishes.each {|selected_item|
      puts "You have selected #{selected_item[:quantity]} #{selected_item[:dish]} at £#{selected_item[:price]} each"
    }
    total
  end

  def included_in_menu(dish)
    MenuListRequest::DISHES.detect { |item| item[:dish] == dish }
  end

  def included_in_order(dish)
    @selected_dishes.detect { |item| item[:dish] == dish}
  end

  def update_existing_quantity_selected(dish, quantity)
    @selected_dishes.find {|item| item[:dish] == dish
      item[:quantity] = (item[:quantity] += quantity)
    }
  end

  def add_to_order(dish, quantity)
    dish = MenuListRequest::DISHES.find { |item| item[:dish] == dish }
    dish[:quantity] = quantity
    @selected_dishes << dish
  end

  def total
    @order_total = 0
    @selected_dishes.each {|item|
      @order_total += (item[:price] * item[:quantity])
    }
    puts "Your order total is £#{@order_total}"
  end

  def expected_delivery_time
    time = (Time.now + (60 * 60)).strftime('%H:%M')
  end

  def send_message
    account_sid = TWILIO_ACCOUNT_SID
    auth_token = TWILIO_ACCOUNT_AUTH_TOKEN
   @client = Twilio::REST::Client.new(account_sid, auth_token)
   message = @client.messages
     .create(
        body: "Thank you! Your order was placed and will be delivered before #{expected_delivery_time}" ,
        from: "+441733530262",
        to: "+447449652308"
      )
    @order_message_sid << message.sid
  end
end
