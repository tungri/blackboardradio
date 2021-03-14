class TweetsController < ApplicationController
  def index
    @tweets = Tweet.where(status: :published).order(created_at: :desc).eager_load(:user).all
  end

  def drafts
    @draft_tweets = Tweet.where(status: :drafted, user: current_user).order(created_at: :desc).all
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    @tweet.status = :drafted if params[:commit] == 'Draft Tweet'
    @tweet.save
    redirect_to tweets_path
  end

  def show
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    @tweet = Tweet.find(params[:id])
    if @tweet.update(tweet_params)
      redirect_to tweets_drafts_url
    else
      render :edit
    end
  end

  def publish
    @tweet = Tweet.find(params[:id])
    @tweet.status = :published
    @tweet.save()
    redirect_to tweets_path
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.status = :deleted
    @tweet.save()
    redirect_to tweets_drafts_url
  end

  private

    def tweet_params
      params.require(:tweet).permit(:content)
    end
end
