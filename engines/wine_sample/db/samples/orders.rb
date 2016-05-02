Spree::Sample.load_sample("addresses")

orders = []
orders << Spree::Order.find_or_create_by(
  :number => "R123456789",
  :email => "spree@example.com",
  :item_total => 150.95,
  :adjustment_total => 150.95,
  :total => 301.90,
  :shipping_address => Spree::Address.first,
  :billing_address => Spree::Address.last)

orders << Spree::Order.find_or_create_by(
  :number => "R987654321",
  :email => "spree@example.com",
  :item_total => 15.95,
  :adjustment_total => 15.95,
  :total => 31.90,
  :shipping_address => Spree::Address.first,
  :billing_address => Spree::Address.last)


o1 = orders[0]
if o1.persisted? && o1.line_items.empty?
  o1.line_items.create(
    :variant => Spree::Product.last.master,
    :quantity => 1,
    :price => 15.99)
end

o2 = orders[1]
if o2.persisted? && o2.line_items.empty?
  o2.line_items.create(
    :variant => Spree::Product.last.master,
    :quantity => 1,
    :price => 22.99)
end

orders.each(&:create_proposed_shipments)

orders.each do |order|
  order.state = "complete"
  order.completed_at = Time.current - 1.day
  order.save
end
