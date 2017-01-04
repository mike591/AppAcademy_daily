# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Todo.create(title: "hello", body: "hello body")
Todo.create(title: "cats", body: "smile")
Todo.create(title: "dogs", body: "wash dog")

Step.create(title: "hello step", body: "hello step body", todo_id: 1)
Step.create(title: "hello step 2", body: "hello step body 2", todo_id: 1)
