class Milestone < ActiveRecord::Base
  belongs_to :tender
  belongs_to :performer
  has_many :comments, as: :commentable, :dependent => :destroy

  validates :name, presence: true

  def code?(value)
    code == value
  end

  def self.to_text
    string = ""
    milestones = []

    all.each do |milestone|
      milestones << %Q(#{milestone.name}
#{Milestone.human_attribute_name(:performer_id)} - #{milestone.performer.full_name}
#{Milestone.human_attribute_name(:estimate_date)} - #{milestone.estimate_date}
#{Milestone.human_attribute_name(:tender_date)} - #{milestone.tender_date}
#{Milestone.human_attribute_name(:complete_date)} - #{milestone.complete_date})
    end

    milestones.join("\n\n")
  end
end
