FactoryGirl.define do
  factory :user, aliases: [:owner] do
    name 'Pigeon Dan'
    email 'test@example.com'
    role 'standard'
    password 'helloworld'
    password_confirmation "helloworld"
    confirmed_at Time.now
  end

end
