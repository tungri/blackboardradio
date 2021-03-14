class TweetsController < ApplicationController
  def index
    @tweets = Tweet.order(created_at: :desc).eager_load(:user).all
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(params.require(:tweet).permit(:content))
    @tweet.user = current_user
    @tweet.save
    redirect_to root_path
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
