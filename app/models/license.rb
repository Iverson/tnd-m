class License < ActiveRecord::Base
  validates :name, presence: true
end
