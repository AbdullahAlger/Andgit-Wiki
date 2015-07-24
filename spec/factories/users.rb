FactoryGirl.define do
  factory :user do
    name 'Pigeon Dan'
    email 'test@example.com'
    password 'helloworld'
    password_confirmation "helloworld"
    confirmed_at Time.now
  end

end
