begin
  north_america = Spree::Zone.find_by_name!("North America")
rescue ActiveRecord::RecordNotFound
  puts "Couldn't find 'North America' zone. Did you run `rake db:seed` first?"
  puts "That task will set up the countries, states and zones required for Spree."
  exit
end

shipping_category = Spree::ShippingCategory.find_or_create_by!(name: 'Default')

shipping_methods = [
  {
    :name => "FedEx Ground (USD)"
  },
  {
    :name => "FedEx 2Day (USD)"
  },
  {
    :name => "FedEx Priority Overnight (USD)"
  },
  {
    :name => "FedEx Ground (EUR)"
  }
]

shipping_methods.each do |m|
  m = Spree::ShippingMethod.find_or_create_by(m)
  m.zones << north_america if m.zones.empty?
  m.shipping_categories << shipping_category if m.shipping_categories.empty?
  next if m.calculator
  m.calculator = Spree::Calculator::Shipping::FlatRate.create!
  m.save!
end

{
  "FedEx Ground (USD)" => [5, "USD"],
  "FedEx Ground (EUR)" => [5, "USD"],
  "FedEx Priority Overnight (USD)" => [15, "USD"],
  "FedEx 2Day (USD)" => [10, "USD"]
}.each do |shipping_method_name, (price, currency)|
  shipping_method = Spree::ShippingMethod.find_by_name!(shipping_method_name)
  shipping_method.calculator.preferences = {
    amount: price,
    currency: currency
  }
  shipping_method.calculator.save!
  shipping_method.save!
end

