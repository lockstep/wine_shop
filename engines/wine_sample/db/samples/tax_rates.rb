north_america = Spree::Zone.find_by_name!("North America")
wine = Spree::TaxCategory.find_by_name!("Wine")
tax_rate = Spree::TaxRate.find_or_create_by(
  :name => "North America",
  :zone => north_america, 
  :amount => 0.05,
  :tax_category => wine)
tax_rate.calculator = Spree::Calculator::DefaultTax.create!
tax_rate.save!
