require 'csv'
require 'open-uri'
Spree::Sample.load_sample("tax_categories")
Spree::Sample.load_sample("shipping_categories")
Spree::Sample.load_sample("taxons")
wine = Spree::TaxCategory.find_by_name!("Wine")
shipping_category = Spree::ShippingCategory.find_by_name!("Default")
Spree::Sample.load_sample("option_values")

products = []
wines = CSV.read(File.join(File.dirname(__FILE__), '..', 'wines.csv'))
wines.shift
wines.each do |wine_attr_array|
  sku, name, description, wine_type, year, volume, price, sale_price, url =
    wine_attr_array[0], wine_attr_array[1], wine_attr_array[2],
    wine_attr_array[3], wine_attr_array[4], wine_attr_array[5],
    wine_attr_array[6], wine_attr_array[7], wine_attr_array[8]
  products.push({
    :name => name,
    :tax_category => wine,
    :shipping_category => shipping_category,
    :price => price,
    :eur_price => sale_price,
    :available_on => Time.zone.now,
    :description => description,
    :sku => sku,
    :grape => wine_type,
    :year => year,
    :url => url,
    :volume => volume
  })
end

products.each do |product_attrs|
  eur_price = product_attrs.delete(:eur_price)
  price = product_attrs.delete(:price)
  sku = product_attrs.delete(:sku)
  year = product_attrs.delete(:year)
  grape = product_attrs.delete(:grape)
  url = product_attrs.delete(:url)
  product_attrs.delete(:volume)
  Spree::Config[:currency] = "USD"

  default_shipping_category = Spree::ShippingCategory.find_by_name!("Default")
  product = Spree::Product.find_or_create_by(product_attrs)
  product.price = price
  unless product.valid?
    p product.errors
  end
  product.save!
  Spree::Config[:currency] = "EUR"
  product.reload
  product.price = eur_price
  product.shipping_category = default_shipping_category
  product.save!
  Spree::Config[:currency] = "USD"
  product.reload
  {
    'Year' => year, 'Grape' => grape
  }.each do |prop_name, prop_value|
    product.set_property(prop_name, prop_value)
  end
  year_taxon = Spree::Taxon.find_by(name: year.to_s)
  year_taxon.products << product if year_taxon
  grape_taxon = Spree::Taxon.find_by(name: grape)
  grape_taxon.products << product if grape_taxon
  small = Spree::OptionValue.where(name: "750").first
  medium = Spree::OptionValue.where(name: "1000").first
  large = Spree::OptionValue.where(name: "1500").first
  sizes = [small, medium, large]
  variants = [{
    :product => product,
    :sku => sku + '-750',
    :cost_price => price.to_f - 2
  },{
    :product => product,
    :sku => sku + '-1000',
    :cost_price => price.to_f
  },{
    :product => product,
    :sku => sku + '-1500',
    :cost_price => price.to_f + 2
  }]
  variants.each_with_index do |variant, i|
    v = Spree::Variant.find_or_create_by(variant)
    v.option_values << sizes[i] if v.option_values.empty?
  end
  product.master.update(sku: sku, price: price)
  next unless product.master.images.empty?
  begin
    file = StringIO.new(open(url) {|f| f.read })
    product.master.images.create!(attachment: file)
  rescue OpenURI::HTTPError, Net::OpenTimeout
    puts url
    next
  end
end

