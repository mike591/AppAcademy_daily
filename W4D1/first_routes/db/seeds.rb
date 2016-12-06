# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(username: "mike.username")
User.create!(username: "bob.username")
User.create!(username: "AI.username")
User.create!(username: "Number4.username")

Contact.create!(name: "mike", email: "mike@email", user_id: 1)
Contact.create!(name: "bob", email: "bob@email", user_id: 2)
Contact.create!(name: "AI", email: "AI@email", user_id: 3)
Contact.create!(name: "Number4", email: "Number4@email", user_id: 4)

ContactShare.create!(user_id: 2, contact_id: 1)
ContactShare.create!(user_id: 3, contact_id: 1)
ContactShare.create!(user_id: 4, contact_id: 1)
ContactShare.create!(user_id: 1, contact_id: 2)
