FactoryGirl.define do
  factory :user do
  end

  factory :role do
    name 'User'
    ability all: {read: "1"}
  end

  factory :milestone do
    tender
  end

  factory :tender do
    seldon_id 12515
    name 'tender without presale'
    customer 'customer'
    tender_milestones ''
    url 'http://example.com'
    start_date '11.11.2015'
    end_date '21.11.2015'
    start_max_price 999999
    docs_deadline '18.11.2015'
    approve_deadline '18.11.2015'
    completion_date '19.11.2015'

    factory :tender_with_presale do
      name 'tender with presale'

      after(:create) do |tender, evaluator|
        create(:milestone, name: 'PRE-SALE', code: 'presale', tender: tender)
      end
    end
  end

end
