class User < ActiveRecord::Base
  ROLES = %w[user admin]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true
  has_many :comments, dependent: :destroy
  has_many :tenders, :foreign_key => 'performer_id'

  def role?(base_role)
    ROLES.index(base_role.to_s) <= ROLES.index(role)
  end

  def full_name
    position? ? position : name
  end

  private
  def password_required?
    new_record? ? super : false
  end
end
