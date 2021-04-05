class ApiController < ApplicationController
    protect_from_forgery with: :null_session
    # skip_before_action :verify_authenticity_toker
    include ActionController::HttpAuthentication::Basic::ControllerMethods
    http_basic_authenticate_with name: "twitter", password: "clone"
    def index
        array = []
        Tweet.all.each do |tweet|
            array << {:id => tweet.id, :content => tweet.content, :user_id => tweet.user_id, :likes_count => tweet.likes.count, :retweets_count => tweet.reposts.count, :retwitted_from => tweet.repost_id} 
        end
        @tweets = array
        render json: @tweets.last(50)
    end

    def show
        @tweets = Tweet.all
        render json: @tweets.where("DATE(created_at) >= :start_date AND DATE(created_at) <= :end_date", {start_date: params[:start_date], end_date: params[:end_date]})
    end

    def create
        @tweet = Tweet.new(tweet_params)
    
        if @tweet.save
            render json: @tweet, status: :created, location: @tweet
        else
            render json: @tweet.errors, status: :unprocessable_entity
        end
    end
    

    private
    def tweet_params
        params.require(:tweet).permit(:content, :user_id)
    end
end

