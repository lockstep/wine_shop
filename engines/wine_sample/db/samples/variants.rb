# Spree::Sample.load_sample("option_values")
# Spree::Sample.load_sample("products")
#
# ror_baseball_jersey = Spree::Product.find_by_name!("Ruby on Rails Baseball Jersey")
# ror_tote = Spree::Product.find_by_name!("Ruby on Rails Tote")
# ror_bag = Spree::Product.find_by_name!("Ruby on Rails Bag")
# ror_jr_spaghetti = Spree::Product.find_by_name!("Ruby on Rails Jr. Spaghetti")
# ror_mug = Spree::Product.find_by_name!("Ruby on Rails Mug")
# ror_ringer = Spree::Product.find_by_name!("Ruby on Rails Ringer T-Shirt")
# ror_stein = Spree::Product.find_by_name!("Ruby on Rails Stein")
# spree_baseball_jersey = Spree::Product.find_by_name!("Spree Baseball Jersey")
# spree_stein = Spree::Product.find_by_name!("Spree Stein")
# spree_jr_spaghetti = Spree::Product.find_by_name!("Spree Jr. Spaghetti")
# spree_mug = Spree::Product.find_by_name!("Spree Mug")
# spree_ringer = Spree::Product.find_by_name!("Spree Ringer T-Shirt")
# spree_tote = Spree::Product.find_by_name!("Spree Tote")
# spree_bag = Spree::Product.find_by_name!("Spree Bag")
# ruby_baseball_jersey = Spree::Product.find_by_name!("Ruby Baseball Jersey")
# apache_baseball_jersey = Spree::Product.find_by_name!("Apache Baseball Jersey")
#
# small = Spree::OptionValue.where(name: "Small").first
# medium = Spree::OptionValue.where(name: "Medium").first
# large = Spree::OptionValue.where(name: "Large").first
# extra_large = Spree::OptionValue.where(name: "Extra Large").first
#
# red = Spree::OptionValue.where(name: "Red").first
# blue = Spree::OptionValue.where(name: "Blue").first
# green = Spree::OptionValue.where(name: "Green").first
#
# variants = [
#   {
#     :product => ror_baseball_jersey,
#     :option_values => [small, red],
#     :sku => "ROR-00001",
#     :cost_price => 17
#   },
#   {
#     :product => ror_baseball_jersey,
#     :option_values => [small, blue],
#     :sku => "ROR-00002",
#     :cost_price => 17
#   },
#   {
#     :product => ror_baseball_jersey,
#     :option_values => [small, green],
#     :sku => "ROR-00003",
#     :cost_price => 17
#   },
#   {
#     :product => ror_baseball_jersey,
#     :option_values => [medium, red],
#     :sku => "ROR-00004",
#     :cost_price => 17
#   },
#   {
#     :product => ror_baseball_jersey,
#     :option_values => [medium, blue],
#     :sku => "ROR-00005",
#     :cost_price => 17
#   },
#   {
#     :product => ror_baseball_jersey,
#     :option_values => [medium, green],
#     :sku => "ROR-00006",
#     :cost_price => 17
#   },
#   {
#     :product => ror_baseball_jersey,
#     :option_values => [large, red],
#     :sku => "ROR-00007",
#     :cost_price => 17
#   },
#   {
#     :product => ror_baseball_jersey,
#     :option_values => [large, blue],
#     :sku => "ROR-00008",
#     :cost_price => 17
#   },
#   {
#     :product => ror_baseball_jersey,
#     :option_values => [large, green],
#     :sku => "ROR-00009",
#     :cost_price => 17
#   },
#   {
#     :product => ror_baseball_jersey,
#     :option_values => [extra_large, green],
#     :sku => "ROR-00010",
#     :cost_price => 17
#   },
# ]
#
# Spree::Variant.create!(variants)
# #
# # masters.each do |product, variant_attrs|
# #   product.master.update_attributes!(variant_attrs)
# # end
