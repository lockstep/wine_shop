taxonomies = [
  { name: "Year" },
  { name: "Variety" }
]

taxonomies.each do |taxonomy_attrs|
  Spree::Taxonomy.find_or_create_by(taxonomy_attrs)
end
