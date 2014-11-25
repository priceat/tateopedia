require 'faker'

User.destroy_all
Wiki.destroy_all

5.times do
  user = User.new(
    name:     Faker::Name.name,
    email:    Faker::Internet.email,
    password: Faker::Lorem.characters(10)
    role: standars
  )
  user.skip_confirmation!
  user.save!
end
users = User.all

# Create Wikis
50.times do
   Wiki.create!(
     title:  Faker::Lorem.sentence,
     body:   Faker::Lorem.paragraph,
     private: false
   )
 end
 Wikis = Wiki.all


 puts "Seed finished"
 puts "#{User.count} users created"
 puts "#{Wiki.count} wikis created"