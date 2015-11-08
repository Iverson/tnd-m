class TenderLicense < ActiveRecord::Base
  belongs_to :license
  belongs_to :tender
end
