# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
Cat.create!(birth_date: "12/5/2005", name: "Winter", color: "white", sex: "F", description: "Is Cold", user_id: 1)
Cat.create!(birth_date: "3/5/2015", name: "Number1", color: "black", sex: "M", description: "1", user_id: 1)
Cat.create!(birth_date: "1/1/1900", name: "TimeTraveller", color: "orange", sex: "M", description: "I am old", user_id: 3)
Cat.create!(birth_date: "2/4/2016", name: "Another", color: "white", sex: "F", description: "Another Cat", user_id: 1)
Cat.create!(name: 'Finn', color: 'black', sex: 'M', birth_date: "2013/01/20", user_id: 2)
Cat.create!(name: 'Storm', color: 'black', sex: 'M', birth_date: "2006/09/13", user_id: 2)
Cat.create!(name: 'Sasha', color: 'brown', sex: 'F', birth_date: "1985/10/13", user_id: 3)
Cat.create!(name: 'Snowball', color: 'white', sex: 'F', birth_date: "2012/01/20", user_id: 1)
Cat.create!(name: 'Kitty Chaos', color: 'orange', sex: 'F', birth_date: "1990/06/05", user_id: 1)
Cat.create!(name: 'Cheeto', color: 'orange', sex: 'M', birth_date: "2015/03/30", user_id: 2)

CatRentalRequest.create!(cat_id: 7, start_date: '1/2/2013', end_date: '5/2/2013', user_id: 1)
CatRentalRequest.create!(cat_id: 2, start_date: '2/1/2015', end_date: '2/3/2015', user_id: 1)
CatRentalRequest.create!(cat_id: 2, start_date: '1/4/2016', end_date: '1/5/2016', user_id: 1)
CatRentalRequest.create!(cat_id: 10, start_date: '1/2/2015', end_date: '1/5/2015', user_id: 3)
CatRentalRequest.create!(cat_id: 5, start_date: '1/2/2015', end_date: '1/5/2015', user_id: 3)
CatRentalRequest.create!(cat_id: 6, start_date: '1/2/2015', end_date: '1/5/2015', user_id: 2)
CatRentalRequest.create!(cat_id: 9, start_date: '1/2/2015', end_date: '1/5/2015', user_id: 2)

User.create!(user_name: 'michael', password: 'password')
User.create!(user_name: 'dischorde', password: 'hunter2')
User.create!(user_name: 'katarina', password: 'abc123')
