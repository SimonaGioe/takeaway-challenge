require 'order'
require 'menu_list_request'

describe Order do

  context "#selected" do
    it "starts an order and add dish to selected_dishes if dish exist in the menu" do
      subject.selected("American Pizza", 2)
      expect(subject.selected_dishes).to eq [{:dish => "American Pizza", :price => 12.50, :quantity => 2}]
    end

    it "updates quantity of selected item when adding an existing dish to selection" do
      subject.selected("American Pizza", 2)
      subject.selected("American Pizza", 1)
      expect(subject.selected_dishes).to eq [{:dish => "American Pizza", :price => 12.50, :quantity => 3}]
    end

    it "raises an error if dish selected is not in the menu" do
      expect { subject.selected("mango", 2) }.to raise_error "Dish not included in the menu"
    end
  end

  context "#complete" do
    it "sends a message to customer with expected delivery time and populate order_message_sid" do
      subject.selected("American Pizza", 2)
      time = (Time.now + (60 * 60)).strftime('%H:%M')
      subject.complete
      expect(subject.order_message_sid.empty?).to eq false
    end

  end

end
