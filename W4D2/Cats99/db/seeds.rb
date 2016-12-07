# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Cat.create!(birth_date: "12/5/2005", name: "Winter", color: "White", sex: "F", description: "Is Cold")
Cat.create!(birth_date: "3/5/2015", name: "Number1", color: "Black", sex: "M", description: "1")
Cat.create!(birth_date: "1/1/1900", name: "TimeTraveller", color: "Orange", sex: "M", description: "I am old")
Cat.create!(birth_date: "2/4/2016", name: "Another", color: "White", sex: "F", description: "Another Cat")

CatRentalRequest.create!(cat_id: 1, start_date: '1/2/2013', end_date: '5/2/2013')
CatRentalRequest.create!(cat_id: 2, start_date: '2/1/2015', end_date: '2/3/2015')
CatRentalRequest.create!(cat_id: 2, start_date: '1/4/2016', end_date: '1/5/2016')
CatRentalRequest.create!(cat_id: 4, start_date: '1/2/2015', end_date: '1/5/2015')
