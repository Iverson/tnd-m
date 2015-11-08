# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admins = Role.where("ability#>>'{all, manage}' = ?", "1")

if admins.exists?
  admin_role = admins.first
  u1 = User.find_or_initialize_by(email: "admin@admin.com")
  u1.update({name: "admin", email: "admin@admin.com", password: "12345", password_confirmation: "12345", role_id: admin_role.id})
end
