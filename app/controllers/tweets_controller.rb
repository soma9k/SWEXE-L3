class TweetsController < ApplicationController
  def index
    @tweet = Tweet.all 
  end
  def new
    @tweet = Tweet.new
  end
  def create
    file = params[:tweet][:file].read
    @tweet = Tweet.new(message: params[:tweet][:message], file: file, tdate: Time.current)
    if @tweet.save
      flash[:notice] = '1レコード追加しました'
      redirect_to tweets_path
    else
      render 'new'
    end
  end
  def show
    @tweet = Tweet.find(params[:id])
  end
  def destroy
    tweet = Tweet.find(params[:id])
    if tweet.destroy
      flash[:notice] = '1レコード削除しました'
    end
    redirect_to tweets_path
  end
  def edit
    @tweet = Tweet.find(params[:id])
  end
  def update
    @tweet = Tweet.find(params[:id])
    file = params[:tweet][:file].read
    if @tweet.update(message: params[:tweet][:message], file: file)
      flash[:notice] = '1レコード更新しました'
      redirect_to tweets_path
    else
      render 'edit'
    end
  end
  def get_image
    tweet = Tweet.find(params[:id]) 
    send_data tweet.file, disposition: :inline, type: 'image/jpg'
  end
end
