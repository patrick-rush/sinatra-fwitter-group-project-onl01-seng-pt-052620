class UsersController < ApplicationController

    include BCrypt

    get '/signup' do
        erb :'/users/signup'
    end
    
    post '/signup' do
        user = User.new(username: params[:username], email: params[:email], password: params[:password])
        if user.save
            session[:user_id] = user.id
            redirect to '/tweets'
        else
            redirect to '/signup'
        end
    end

    get '/login' do
        if logged_in?(session)
            redirect to '/tweets'
        else
            erb :'/users/login'
        end 
    end
    
    post '/login' do
        user = User.find_by(username: params[:username])
    
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect to '/tweets'
        else
            redirect to '/login'
        end
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        # binding.pry
        @tweets = @user.tweets
        erb :'/users/show'
    end
        
    get '/logout' do
        session.clear
        redirect to '/login'
    end

end
