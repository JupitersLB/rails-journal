# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Cleaning database"
Post.delete_all
User.delete_all
puts "Cleaned"

puts "Creating users"
params = {}
params[:first_name] = "Liam"
params[:second_name] = "Baker"
params[:password] = "password"
params[:email] = "liam.baker@journal.com"
new_user = User.new(params)
new_user.save
puts "Created user #{new_user.id}"

params = {}
params[:first_name] = "John"
params[:second_name] = "Doe"
params[:password] = "password"
params[:email] = "john.doe@journal.com"
new_user = User.new(params)
new_user.save
puts "Created user #{new_user.id}"

puts "Users created!"

puts "Creating posts"
10.times do
  params = {}
  params[:title] = Faker::GreekPhilosophers.quote
  params[:content] = Faker::Hacker.say_something_smart
  params[:date] = Date.today.to_formatted_s(:long)
  params[:user] = User.all.sample
  new_post = Post.new(params)
  new_post.save
  puts "Created post #{new_post.id}"
end
puts "Posts created"
puts "Finished seeding"
