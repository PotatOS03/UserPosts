class PostsController < ApplicationController
  def index
    # Order posts by most recent first
    @posts = Post.order(created_at: :desc)
  end

  def show
    # Ensure the post exists, otherwise render not found
    not_found unless @post = Post.find_by(id: params[:id])
  end

  def new
    # Ensure the user is signed in before allowing them to create a post
    return redirect_to new_user_session_path, alert: "You must be signed in to create a post." unless user_signed_in?

    # Initialize a new post object for the form
    @post = Post.new
  end

  def create
    # Ensure the user is signed in before allowing them to create a post
    return redirect_to new_user_session_path, alert: "You must be signed in to create a post." unless user_signed_in?

    @post = Post.new(post_params)

    # Set the post's user_id to the current user's id
    @post.user_id = current_user.id

    if @post.save
      redirect_to @post, notice: "Post was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])

    # Ensure the user is authorized to delete the post
    return redirect_to posts_path, alert: "You are not authorized to delete this post." unless user_signed_in? && current_user == @post.user

    if @post.destroy
      redirect_to posts_path, notice: "Post was successfully deleted."
    else
      redirect_to @post, alert: "Error deleting post."
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :user_id)
  end
end
