prototypes = [
  {
    :name => "Wine",
    :properties => ["Year", "Grape"]
  }
]

prototypes.each do |prototype_attrs|
  prototype = Spree::Prototype.find_or_create_by(:name => prototype_attrs[:name])
  prototype_attrs[:properties].each do |property|
    p = Spree::Property.where(name: property).first
    next if prototype.properties.include?(p)
    prototype.properties << p
  end
end
