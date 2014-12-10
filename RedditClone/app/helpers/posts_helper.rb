module PostsHelper
  def comments_link(post)
    link_to post.comment_threads.size.to_s + " comment".pluralize(post.comment_threads.size), post_by_title_path(post.community, post)
  end
end
