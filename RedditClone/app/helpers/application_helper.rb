module ApplicationHelper
  def upvote_class(votable, current_user)
    if current_user && current_user.voted_up_on?(votable)
      button_class = "upvote-button"
    else
      button_class = "vote-button"
    end

    "glyphicon glyphicon-chevron-up " + button_class
  end

  def downvote_class(votable, current_user)
    if current_user && current_user.voted_down_on?(votable)
      button_class = "downvote-button"
    else
      button_class = "vote-button"
    end

    "glyphicon glyphicon-chevron-down " + button_class
  end
end
