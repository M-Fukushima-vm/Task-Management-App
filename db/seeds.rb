# coding: utf-8

User.create!( name: "Admin User",
              email: "sample@email.com",
              password: "password",
              password_confirmation: "password",
              admin: true)
              
User.create!( name: "Gadmin User",
              email: "sample-1@email.com",
              password: "password",
              password_confirmation: "password",
              admin: true)
              
99.times do |n|
  name  = Faker::Name.name
  email = "sample-#{n+2}@email.com"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end

50.times do |n|
  title = "サンプル#{n+1}"
  detail = "test#{n+1}"
  users = User.order(:created_at).take(3);
  users.each { |user| user.tasks.create!(title: title, detail: detail) }
end
