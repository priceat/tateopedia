require 'faker'

#User.destroy_all
Wiki.destroy_all

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
 puts "#{Wiki.count} wikis created"