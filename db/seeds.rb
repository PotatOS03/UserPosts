# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require "faker"

# Create some default users
3.times do
  # Use Faker to generate random user data
  # Ensure that the email is unique by using Faker's unique method
  Faker::UniqueGenerator.clear # Clear previous unique values to avoid conflicts
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = Faker::Internet.email(name: "#{first_name} #{last_name}")
  User.create!(
    first_name: first_name,
    last_name: last_name,
    email: email,
    password: "password",
    password_confirmation: "password"
  )
end

# Create some default posts
15.times do
  user = User.order("RANDOM()").first # Randomly select a user for each post
  # Use Faker to generate random post data
  Post.create!(
    title: Faker::Lorem.sentence(word_count: rand(3..10)),
    body: Faker::Lorem.paragraph(sentence_count: rand(2..15)),
    user: user
  )
end

# Ensure that each user has at least one post
User.find_each do |user|
  if user.posts.count.zero?
    user.posts.create!(
      title: "Welcome Post",
      body: "This is a welcome post for #{user.first_name}.",
      user: user
    )
  end

  # Print the user's email to help with logging in
  puts user.email
end
