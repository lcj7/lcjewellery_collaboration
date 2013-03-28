# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.create({ email: "splitnova@gmail.com", password:"lcj7password", password_confirmation: "lcj7password"})
User.create({ email: "nick@influitive.com", password:"lcj7password", password_confirmation: "lcj7password"})