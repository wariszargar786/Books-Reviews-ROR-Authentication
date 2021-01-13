5.times do |n|
  p "Create User #{n}"
  User.create! email:Faker::Internet.email,
               password:'password'
end
50.times do |n|
  p "Create Blog No #{n}"

  Blog.create! title: Faker::Book.title,
               body: Faker::Address.full_address,
               user_id: rand(1..5)
end