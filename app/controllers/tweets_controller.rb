class TweetsController < ApplicationController

    get '/tweets' do
        if logged_in?(session)
            @user = current_user(session)
            @tweets = Tweet.all
            erb :'/tweets/tweets'
        else
            redirect to '/login'
        end
    end

    get '/tweets/new' do
        if logged_in?(session)
            @user = current_user(session)
            erb :'/tweets/new'
        else 
            redirect to '/login'
        end
    end

    get '/tweets/:id' do
        if logged_in?(session)
            @tweet = Tweet.find(params[:id])
            erb :'/tweets/show_tweet'
        else
            redirect to '/login'
        end
    end

    get '/tweets/:id/edit' do
        # binding.pry
        if logged_in?(session)
            @tweet = Tweet.find(params[:id])
            @user = User.find(@tweet.user_id)
            erb :'/tweets/edit_tweet'
        else
            redirect to '/login'
        end
    end

    patch '/tweets/:id' do
        # binding.pry
        tweet = Tweet.find(params[:id])
        user = User.find(tweet.user_id)
        if user == current_user(session)
            if params[:content].empty?
                redirect to "/tweets/#{tweet.id}/edit"
            else
                tweet.update(content: params[:content])
                redirect to '/tweets'
            end
        else
            redirect to '/tweets'
        end
    end

    delete '/tweets/:id' do
        if logged_in?(session)
            @user = current_user(session)
            @tweet = Tweet.find(params[:id])
            if @user.id == @tweet.user_id
                @tweet.delete
                redirect to '/tweets'
            else
                redirect to '/tweets'
            end
        else
            redirect to '/login'
        end
    end

    post '/tweets' do
        # binding.pry
        if params[:content].empty?
            redirect to '/tweets/new'
        else
            Tweet.create(content: params[:content], user_id: current_user(session).id)
            redirect to '/tweets'
        end
        # binding.pry
    end

    # get '/tweets/new' do
    #     if logged_in?(session)
    #         erb :'/tweets/new'
    #     end
    # end

end
