class ApiController < ActionController::API
    before_action :set_tweet, only: %i[ edit update destroy ]
    def fifty_tweets
        response = []
        @tweets = Tweet.all
        @tweets.order(id: :desc).limit(50).each do |tweet|
            content = tweet.content
            response.push(content)
        end
        return render json: response
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