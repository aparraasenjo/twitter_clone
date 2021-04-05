class ApiController < ApplicationController
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
end

