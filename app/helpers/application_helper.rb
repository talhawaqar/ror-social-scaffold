# rubocop:disable Layout/LineLength
module ApplicationHelper
  def menu_link_to(link_text, link_path)
    class_name = current_page?(link_path) ? 'menu-item active' : 'menu-item'

    content_tag(:div, class: class_name) do
      link_to link_text, link_path
    end
  end

  def like_or_dislike_btn(post)
    like = Like.find_by(post: post, user: current_user)
    if like
      link_to('Dislike!', post_like_path(id: like.id, post_id: post.id), method: :delete)
    else
      link_to('Like!', post_likes_path(post_id: post.id), method: :post)
    end
  end

  def friendship_status(user)
    if current_user.friend?(user)
      link_to 'Unfriend', unfriend_user_path(user.id), method: :post
    elsif current_user.friendships.where(friend_id: user.id, confirmed: false).exists?
      link_to 'Cancel Request', cancel_request_user_path(user.id), method: :post
    elsif current_user.inverse_friendships.where(user_id: user.id, confirmed: false).exists?
      "#{link_to 'Accept Request', accept_user_path(user.id), method: :post}   #{link_to 'Reject Request', reject_user_path(user.id), method: :post}".html_safe
    else
      link_to 'Send Request', addfriend_user_path(user.id), method: :post
    end
  end
end
# rubocop:enable Layout/LineLength
