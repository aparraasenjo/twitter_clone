class HomeController < ApplicationController
  def index
    @q = Tweet.includes([:user, :likes]).order('created_at DESC').page(params[:page]).ransack(params[:q])
    @tweets = @q.result(distinct: true)
    @tweet = Tweet.new
  
  end

  def friends
    @tweets = Tweet.includes([:user, :likes]).order('created_at DESC').page(params[:page]).tweets_for_me(current_user.friends.pluck(:friend_id))
    @tweet = Tweet.new
  end

  def hashtags
    tag = Tag.find_by(name: params[:name])
    @q = tag.tweets.includes([:user, :likes]).order('created_at DESC').page(params[:page]).ransack(params[:q])
    @tweets = @q.result(distinct: true)
    @tweet = Tweet.new
  end

end
