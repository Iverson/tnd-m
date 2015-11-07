class AddDefaultRolesAndSetToExistsUsers < ActiveRecord::Migration
  def up
    admin_role = Role.create(name: "Admin", ability: {all: {manage: true}})
    user_role  = Role.create(name: "User", ability: {all: {read: true}, comment: {create: true}})

    User.all.each do |user|
      role_id = admin_role.id if user.attributes["role"] == "admin"
      role_id = user_role.id if user.attributes["role"] == "user"

      user.update(role_id: role_id)
    end
  end

  def down
    Role.find_by(name: "Admin").delete
    Role.find_by(name: "User").delete
  end
end
