require 'menu_list_request'
require 'customer'

describe MenuListRequest do

  it "shows menu to customer" do
    customer = Customer.new
    expect(subject.show(customer)).to eq MenuListRequest::DISHES
  end

end
