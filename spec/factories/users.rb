FactoryGirl.define do
  factory :user do
    name 'Pigeon Dan'
    email 'test@example.com'
    role {|r| "#{r}"}
    password 'helloworld'
    password_confirmation "helloworld"
    confirmed_at Time.now
  end
end
