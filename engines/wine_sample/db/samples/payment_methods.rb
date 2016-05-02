Spree::Gateway::Bogus.find_or_create_by(
  {
    name: "Credit Card",
    description: "Fake payment gateway.",
    active: true
  }
)

Spree::PaymentMethod::Check.find_or_create_by(
  {
    name: "Check",
    description: "Pay by check.",
    active: true
  }
)
