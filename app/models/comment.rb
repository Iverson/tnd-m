class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates :message, presence: true

  def self.to_text(options = {})
  	comments = [];

  	all.each do |comment|
  		comments << "#{comment.user.name} #{comment.created_at.strftime("%d %B %Y, %H:%M")} \n#{comment.message}"
  	end

  	comments.join("\n\n")
  end
end
