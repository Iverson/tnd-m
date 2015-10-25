# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

unless User.exists?
  u1 = User.create!({name: "admin", email: "admin@admin.com", password: "12345", password_confirmation: "12345", role: "admin"})
  u2 = User.create!({name: "example", email: "example@example.com", password: "12345", password_confirmation: "12345", role: "user"})
end