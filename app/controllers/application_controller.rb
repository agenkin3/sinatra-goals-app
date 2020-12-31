
require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "our_awesome_journal_app"
  end

  get '/goal_entries_new' do
    redirect_if_not_logged_in
    erb :'/goal_entries/new'
  end

  get "/" do
    redirect_if_logged_in
    erb :welcome
  end

  

  helpers do

    def logged_in?
      # true if user is logged in, otherwise false
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end
#if find doesn't return what it's looking for it returns error which is why we use find_by
#find_by is an activerecord method that is going to query the database
#using @ reduces the number of database calls
#or equals || will create and assign if the current user is found
#helpers are available through views and controllers

    def authorized_to_edit?(goal_entry)
      goal_entry.user == current_user
    end

    # use this helper method to protect controller actions where user must be logged in to proceed
    def redirect_if_not_logged_in
      if !logged_in?
        flash[:errors] = "You must be logged in to view the page you tried to view."
        redirect '/'
      end
    end

    # use this helper method to avoid showing welcome, login, or signup page to a user that's already logged in
    def redirect_if_logged_in
      if logged_in?
        redirect "/users/#{current_user.id}"
      end
    end

    
  
    end


  end