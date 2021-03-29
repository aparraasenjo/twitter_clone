class LikesController < ApplicationController
  before_action :set_tweet
  before_action :set_like, only: [:destroy]


  # POST /likes or /likes.json
  def create
    @tweet.likes.create(user_id: current_user.id)
    redirect_to root_path
  end

  # DELETE /likes/1 or /likes/1.json
  def destroy
    @like.destroy
    redirect_to root_path
  end

  private
    def set_tweet
      @tweet = Tweet.find(params[:tweet_id])
    end

    def set_like
      @like = @tweet.likes.find(params[:id])
    end
end
