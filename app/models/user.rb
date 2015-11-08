class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true
  belongs_to :role
  has_many :comments, dependent: :destroy

  def full_name
    position? ? position : name
  end

  def is_admin?
    role.ability["all"]["manage"] == "1"
  end

  private
  def password_required?
    new_record? ? super : false
  end
end
