class User < ActiveRecord::Base
  ROLES = %w[user admin]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true

  def role?(base_role)
    ROLES.index(base_role.to_s) <= ROLES.index(role)
  end

  private
  def password_required?
    new_record? ? super : false
  end 
end
