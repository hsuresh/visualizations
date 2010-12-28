require 'twitter'

class TwitterAmplitudeController < ApplicationController
  def show
    if !signed_in?
      redirect_to new_session_path
    end
    @client = client
    @user = client.user(session[:screen_name])
  end

  def tweet_times
    @tweets = client.home_timeline({:count=>200, :trim_user=>true})
    tweet_times = @tweets.collect{|t| DateTime.parse(t.created_at)}
    tweets_by_hour = {}
    (0..23).each do |hour|
      tweets_by_hour[hour.to_s] = tweet_times.select{|t| t.hour == hour}.count
    end
    respond_to do |format|
      format.json{ render :text=> @tweets_by_hour = tweets_by_hour.to_json, :format=>'json'}
    end
  end
end
