# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = User.all

10.times do
  Wiki.create!(
          title: Faker::Lorem.sentence,
          body: Faker::Lorem.paragraph,
          private: false,
          user: users.sample
  )
end

puts "Seed finished!"
puts "#{Wiki.count} wikis created"