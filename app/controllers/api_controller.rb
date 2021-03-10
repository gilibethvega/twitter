class ApiController < ActionController::API
    before_action :set_tweet, only: %i[ edit update destroy ]
    def news
        @tweets = Tweet.all.limit(50).order(id: :desc)
    end

    def tweets_dates
        @twees_n = Tweet.where(:created_at => params[:date]..params[:date_two])
        render json: @tweets_n
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