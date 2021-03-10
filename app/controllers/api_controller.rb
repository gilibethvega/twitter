class ApiController < ActionController::API
    before_action :set_tweet, only: %i[ edit update destroy ]
    def news
        @tweets = Tweet.all.limit(50).order(id: :desc)
    end

    def tweets_dates
      first_date = Date.strptime(params[:date], '%Y-%m-%d')
      end_date = Date.strptime(params[:date_two], '%Y-%m-%d')
      @twees_n = Tweet.all.where(created_at: first_date.midnight..end_date.end_of_day).order(id: :desc)
      render json: @twees_n
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