require 'customer'
require 'menu_list_request'
require 'order'

describe Customer do

  it "expect error when trying to add item not in the menu to order" do
    expect { subject.add_to_order("carne", 2) }.to raise_error "Dish not included in the menu"
  end

  it "adds dish and quantity to selection" do
    subject.add_to_order("American Pizza", 1)
    expect(subject.selection).to eq [{:dish => "American Pizza", :price => 12.50, :quantity => 1}]
  end

end
