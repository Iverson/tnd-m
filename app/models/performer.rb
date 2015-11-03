class Performer < ActiveRecord::Base
  has_many :tenders

  validates :email, presence: true

  def full_name
    position? ? position : name
  end
end
