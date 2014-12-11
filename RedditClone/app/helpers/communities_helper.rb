module CommunitiesHelper
  def subscribe_class(current_user, community)
    if current_user.subscribed? community
      "btn btn-primary btn-block"
    else
      "btn btn-default btn-block"
    end
  end

  def subscribe_text(current_user, community)
    if current_user.subscribed? community
      "Unsubscribe"
    else
      "Subscribe"
    end
  end

  def subscribe_button(current_user, community)
    link_to subscribe_text(current_user, community), community_subscribe_path(community), class: subscribe_class(current_user, community)
  end
end
