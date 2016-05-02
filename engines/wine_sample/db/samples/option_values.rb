Spree::Sample.load_sample("option_types")

volume = Spree::OptionType.find_by_presentation!("Volume")

Spree::OptionValue.find_or_create_by({
  :name => "750",
  :presentation => "750 ML",
  :position => 1,
  :option_type => volume
})
Spree::OptionValue.find_or_create_by({
  :name => "1000",
  :presentation => "1.0 L",
  :position => 2,
  :option_type => volume
})
Spree::OptionValue.find_or_create_by(
  :name => "1500",
  :presentation => "1.5 L",
  :position => 3,
  :option_type => volume
)
