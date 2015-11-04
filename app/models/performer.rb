class Performer < ActiveRecord::Base
  has_many :milstones

  validates :email, presence: true

  def full_name
    position? ? position : name
  end
end
