class HomeController < ApplicationController
  def index
    @tweets = Tweet.page(params[:page])
  end
end
