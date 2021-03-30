class HomeController < ApplicationController
  def index
    @tweets = Tweet.order('created_at DESC').page(params[:page]) #tweets_for_me(current_user.friends.pluck(:friend_id))
    @tweet = Tweet.new
  end

  def friends
    @tweets = Tweet.order('created_at DESC').page(params[:page]).tweets_for_me(current_user.friends.pluck(:friend_id))
    @tweet = Tweet.new
  end
end
