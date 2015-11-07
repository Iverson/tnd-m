class AddDefaultRolesAndSetToExistsUsers < ActiveRecord::Migration
  def up
    admin_role   = Role.create(name: "Администратор", ability: {all: {manage: "1"}})
    user_role    = Role.create(name: "Пользователь", ability: {all: {read: "1"}, comment: {create: "1"}})
    manager_role = Role.create(name: "Менеджер", ability: {all: {read: "1"}, milestone: {manage: "1"}, performer: {manage: "1"}, comment: {create: "1"}})

    User.all.each do |user|
      role_id = admin_role.id if user.attributes["role"] == "admin"
      role_id = user_role.id if user.attributes["role"] == "user"
      role_id = manager_role.id if user.attributes["role"] == "manager"

      user.update(role_id: role_id)
    end
  end

  def down
    Role.find_by(name: "Администратор").delete
    Role.find_by(name: "Пользователь").delete
    Role.find_by(name: "Менеджер").delete
  end
end
