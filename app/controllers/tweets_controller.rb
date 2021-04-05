class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[ show edit update destroy ]
  before_action :set_rtweet, only: %i[ repost friend unfriend ]



  # GET /tweets or /tweets.json
  def index
    @q = Tweet.order('created_at DESC').page(params[:page]).ransack(params[:q])
    @tweets = @q.result(distinct: true)
    # render json: @tweets.each {|tweet| tweet.id}
  end

  # GET /tweets/1 or /tweets/1.json
  def show
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets or /tweets.json
  def create
    @tweet = Tweet.new(tweet_params.merge(user: current_user))

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to root_path, notice: "Tweet was successfully created." }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweets/1 or /tweets/1.json
  def update
    if @tweet.user == current_user
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: "Tweet was successfully updated." }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
    else
      redirect_to root_path, notice: "You did not tweeted this tweet!"
    end
  end

  def repost
    if @tweet
      Tweet.create(user_id: current_user.id, content: "Original Tweet by #{@tweet.user.name}: #{@tweet.content}", repost_id: @tweet.id)
      redirect_to root_path, notice: "Tweet was successfully re-tweeted."
    end
  end

  def friend
      Friend.create(user_id: current_user.id, friend_id: @tweet.user_id)
      redirect_to root_path, notice: "You are now following #{@tweet.user}'s tweets"
  end

  def unfriend
    @friend = Friend.find_by(friend_id: @tweet.user.id)
    @friend.destroy
    redirect_to root_path, notice: "You ceased to follow #{@tweet.user}'s tweets"
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
    def set_rtweet
      @tweet = Tweet.find(params[:tweet_id])
    end

    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:content)
    end
end
