class CommentsController < ApplicationController
  def index
    @tweet = Tweet.find(params[:tweet_id])
    @comments = Comment.where(tweet: @tweet).order(created_at: :desc).eager_load(:user).all
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.tweet_id = params[:tweet_id]
    @comment.save
    redirect_to tweet_comments_url
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to tweet_comments_url
    else
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.delete
    redirect_to tweet_comments_url
  end

  def like
    @comment = Comment.find(params[:id])
    AbstractLike.create(abstract_tweet: @comment, user: current_user)
    redirect_back(fallback_location: root_path)
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end
end
