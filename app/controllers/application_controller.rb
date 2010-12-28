require 'twitter/authentication_helper'

class ApplicationController < ActionController::Base
  include Twitter::AuthenticationHelper
  rescue_from Twitter::Unauthorized, :with => :force_sign_in
  protect_from_forgery

  private
  def oauth_consumer
    @oauth_consumer ||= OAuth::Consumer.new("wIGY2kzvuEKtT7sQAM9Qg", "zlWPq19yzT9uMBW758ziCF8dW9qCuZ4aEl7v2Ykl4", :site => 'http://api.twitter.com', :request_endpoint => 'http://api.twitter.com', :sign_in => true)
  end
  def client
    Twitter.configure do |config|
      config.consumer_key = "wIGY2kzvuEKtT7sQAM9Qg"
      config.consumer_secret = "zlWPq19yzT9uMBW758ziCF8dW9qCuZ4aEl7v2Ykl4"
      config.oauth_token = session['access_token']
      config.oauth_token_secret = session['access_secret']
    end
    @client ||= Twitter::Client.new
  end
  helper_method :client

  def force_sign_in(exception)
    reset_session
    flash[:error] = "It seems your credentials are not good anymore. Please sign in again."
    redirect_to new_session_path
  end
end
