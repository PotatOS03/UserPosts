class UsersController < ApplicationController
  def posts
    # Ensure the user is signed in before allowing them to view their posts
    return redirect_to new_user_session_path, alert: "You must be signed in to view your posts." unless user_signed_in?

    # Fetch the current user's posts, ordered by most recent first
    @user = current_user
    @posts = @user.posts.order(created_at: :desc)
  end
end
