module ApplicationHelper
  def self.upvote_class(current_user)
    if current_user
      button_class = "upvote-button"
    else
      button_class = "vote-button"
    end

    "glyphicon glyphicon-chevron-up " + button_class
  end

  def self.downvote_class(current_user)
    if current_user
      button_class = "downvote-button"
    else
      button_class = "vote-button"
    end

    "glyphicon glyphicon-chevron-down " + button_class
  end
end
