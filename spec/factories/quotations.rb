FactoryGirl.define do
  factory :quotation do
    user nil
    recipientId 1
    quoteId "MyString"
    validUntil "2016-06-24 23:45:58"
    status 1
    subTotal 1.5
    taxRate 1
    tax 1.5
    total 1.5
    note "MyText"
  end
end
