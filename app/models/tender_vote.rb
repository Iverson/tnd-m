class TenderVote < ActiveRecord::Base
  belongs_to :user
  belongs_to :tender

  def to_text
    value ? "Да" : "Нет"
  end

  def self.to_text(options = {})
    votes = [];

    all.each do |vote|
      votes << "#{vote.user.full_name} - #{vote.to_text}"
    end

    votes.join("\n")
  end
end
