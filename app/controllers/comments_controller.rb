class CommentsController < ApplicationController
  before_action :check_if_editable, only: [:update, :destroy]

  def index
    @tweet = Tweet.find(params[:tweet_id])
    @comments = Comment.where(tweet: @tweet).order(created_at: :desc).eager_load(:tweet, :user).all
  end

  def new
    @tweet = Tweet.find(params[:tweet_id])
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
    @tweet = Tweet.find(params[:tweet_id])
    @comment = Comment.find(params[:id])
  end

  def update
    if @comment.update(comment_params)
      redirect_to tweet_comments_url
    else
      render :edit
    end
  end

  def destroy
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

    def check_if_editable
      @comment = Comment.find(params[:id])
      redirect_back(fallback_location: root_path) unless current_user == @comment.user
    end
end
