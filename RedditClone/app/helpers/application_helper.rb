module ApplicationHelper
  def upvote_class(votable, current_user)
    if current_user && current_user.voted_up_on?(votable)
      button_class = "upvote-button"
    else
      button_class = "vote-button"
    end

    "glyphicon glyphicon-arrow-up " + button_class
  end

  def downvote_class(votable, current_user)
    if current_user && current_user.voted_down_on?(votable)
      button_class = "downvote-button"
    else
      button_class = "vote-button"
    end

    "glyphicon glyphicon-arrow-down " + button_class
  end

  def upvote_button(path, item, current_user, id_tag)
    link_to '', path, remote: true,
            class: upvote_class(item, current_user), id: id_tag + "-upvote-" + item.id.to_s
  end

  def downvote_button(path, item, current_user, id_tag)
    link_to '', path, remote: true,
            class: downvote_class(item, current_user), id: id_tag + "-downvote-" + item.id.to_s
  end


end
