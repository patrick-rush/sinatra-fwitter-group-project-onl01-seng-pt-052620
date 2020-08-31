require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  enable :sessions
  set :session_secret, 'secret' 

  get '/' do
    erb :index
  end

  helpers do
    def logged_in?(session)
      !!session[:user_id]
    end

    def current_user(session)
      User.find(session[:user_id])
    end 
  end

  # helpers do
  #   def logged_in?
  #     !!current_user
  #   end

  #   def current_user
  #     @current_user ||= User.find(session[:user_id]) if session[:user_id]
  #   end
  # end

end
