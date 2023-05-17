class AddLikesAndDislikesCountToBlogPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :blog_posts, :likes_count, :integer, default: 0
    add_column :blog_posts, :dislikes_count, :integer, default: 0
  end
end