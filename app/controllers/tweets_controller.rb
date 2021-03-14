class TweetsController < ApplicationController
  before_action :check_if_editable, only: [:update, :publish, :destroy]

  def index
    @tweets = Tweet.where(status: :published).order(created_at: :desc).eager_load(:user).all
  end

  def drafts
    @draft_tweets = Tweet.where(status: :drafted, user: current_user).order(created_at: :desc).all
  end

  def attachments
    filename = "#{params[:filename]}.#{params[:format]}"
    send_file(Rails.root.join("storcage", filename), filename: filename, type: "mime/type")
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    @tweet.status = :drafted if params[:commit] == 'Draft Tweet'
    attachments_paths = upload_files(params[:tweet][:attachments])
    @tweet.attachments = attachments_paths.join(',')
    @tweet.save
    redirect_to tweets_path
  end

  def show
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    attachments_paths = upload_files(params[:tweet][:attachments])
    @tweet.attachments = attachments_paths.join(',')
    if @tweet.update(tweet_params)
      redirect_to tweets_drafts_url
    else
      render :edit
    end
  end

  def publish
    @tweet.status = :published
    @tweet.save()
    redirect_to tweets_path
  end

  def like
    @tweet = Tweet.find(params[:id])
    AbstractLike.create(abstract_tweet: @tweet, user: current_user)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @tweet.status = :deleted
    @tweet.save()
    redirect_to tweets_drafts_url
  end

  private

    def tweet_params
      params.require(:tweet).permit(:content)
    end

    def upload_files(files)
      attachments_paths = []
      files.map do |file|
        extension = file.original_filename.split('.')[-1]
        filename = "#{generate_random_filename}.#{extension}"
        File.binwrite(Rails.root.join("storage", filename), file.read)
        filename
      end
    end

    def generate_random_filename
      return SecureRandom.urlsafe_base64
    end

    def check_if_editable
      @tweet = Tweet.find(params[:id])
      redirect_back(fallback_location: root_path) unless current_user == @tweet.user and @tweeet.status == :drafted
    end
end
