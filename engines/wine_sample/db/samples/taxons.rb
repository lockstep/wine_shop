Spree::Sample.load_sample("taxonomies")

year = Spree::Taxonomy.find_by_name!("Year")
variety = Spree::Taxonomy.find_by_name!("Variety")


taxons = [
  {
    :name => "Variety",
    :taxonomy => variety,
    :position => 0
  },
  {
    :name => "Cabernet Sauvignon",
    :taxonomy => variety,
    :parent => "Variety",
    :position => 1
  },
  {
    :name => "Pinot Noir",
    :taxonomy => variety,
    :parent => "Variety",
    :position => 2
  },
  {
    :name => "Merlot",
    :taxonomy => variety,
    :parent => "Variety",
    :position => 3
  },
  {
    :name => "Chardonnay",
    :taxonomy => variety,
    :parent => "Variety",
    :position => 4
  },
  {
    :name => "Sauvignon Blanc",
    :taxonomy => variety,
    :parent => "Variety",
    :position => 5
  },
  {
    :name => "Riesling",
    :taxonomy => variety,
    :parent => "Variety",
    :position => 6
  },
  {
    :name => "Year",
    :taxonomy => year
  },
  {
    :name => "2010",
    :taxonomy => year,
    :parent => "Year",
    :position => 1
  },
  {
    :name => "2011",
    :taxonomy => year,
    :parent => "Year",
    :position => 2
  },
  {
    :name => "2012",
    :taxonomy => year,
    :parent => "Year",
    :position => 3
  },
  {
    :name => "2013",
    :taxonomy => year,
    :parent => "Year",
    :position => 4
  },
  {
    :name => "2014",
    :taxonomy => year,
    :parent => "Year",
    :position => 5
  },
  {
    :name => "2015",
    :taxonomy => year,
    :parent => "Year",
    :position => 6
  },
  {
    :name => "2016",
    :taxonomy => year,
    :parent => "Year",
    :position => 7
  }
]

taxons.each do |taxon_attrs|
  if taxon_attrs[:parent]
    taxon_attrs[:parent] = Spree::Taxon.where(name: taxon_attrs[:parent]).first
    Spree::Taxon.find_or_create_by(taxon_attrs)
  end
end
