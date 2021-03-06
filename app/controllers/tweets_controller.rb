class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[ show edit update destroy retweet like ]
  before_action :authenticate_user!, only: %i[ edit update destroy retweet like ]

  def retweet
    retweet = Tweet.new(retweet_id: @tweet.id, user: current_user)
    if retweet.save
      redirect_to tweets_path(@tweet), notice: 'Retweetted!'
    elsif (retweet.content.length) > 140
      redirect_to tweets_path(@tweet), alert: 'Cannot retweet because your tweet have more than 140 characters...'
    else
      redirect_to tweets_path(@tweet), alert: 'Cannot retweet'
    end
  end
  def like
    if @tweet.liked?(current_user)
      @tweet.remove_like(current_user)
    else
      @tweet.add_like(current_user)
    end
    if current_user.present?
      redirect_to tweets_path(@tweet)
    else
      redirect_to tweets_path(@tweet), alert: 'Error in your like action'
    end
  end
  # GET /tweets or /tweets.json
  def index
    if signed_in?
      if( params[:search] && !params[:search].empty? )
        @tweets = Tweet.tweets_for_me(current_user).where("content LIKE ?", "%#{params[:search]}%").order(created_at: :desc).page params[:page]
      else
        @tweets = Tweet.tweets_for_me(current_user).order(created_at: :desc).page params[:page]
      end
      @tweet = Tweet.new
    else
      @tweets = Tweet.order(created_at: 'desc').page params[:page]
      redirect_to find_tweets_path
    end
  end

  def find_tweets
    if( params[:search] && !params[:search].empty? )
      @tweets = Tweet.where("content LIKE ?", "%#{params[:search]}%").order(created_at: :desc).page params[:page]
    else
      @tweets = Tweet.order(created_at: 'desc').page params[:page]
    end
  end

  # GET /tweets/1 or /tweets/1.json
  def show
  end

  # GET /tweets/new
  #def new
  #  @tweet = Tweet.new
  #end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets or /tweets.json
  def create
    @tweet = Tweet.new(tweet_params.merge(user: current_user))

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to tweets_path(@tweet), notice: "Tweet was successfully created." }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweets/1 or /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: "Tweet was successfully updated." }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1 or /tweets/1.json
  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: "Tweet was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end
    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:content, :user_id, :retweet_id )
    end

end
