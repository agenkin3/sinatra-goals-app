
require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "our_awesome_journal_app"
    register Sinatra::Flash
  end

  get "/" do
    redirect_if_logged_in
    erb :welcome
  end

  helpers do
    #helpers are available through views and controllers
    
    def logged_in?
      # true if user is logged in, otherwise false
      # this will always return a boolean value: false or true
      !!current_user
    end

    def current_user
      # GET value from session: session[:user_id] => 1
      # User.find_by(id: 1)
      @current_user ||= User.find_by(id: session[:user_id])
      #using @ reduces the number of database calls
    end

    def authorized_to_edit?(goal_entry)
      goal_entry.user == current_user
    end

    # #protect controller actions where user must be logged in to proceed
    def redirect_if_not_logged_in
      if !logged_in?
        flash[:notice] = "You must be logged in to view the page you tried to view."
      redirect '/'
      end
    end
    
    #avoid showing welcome, login, or signup page to a user that's already logged in
    def redirect_if_logged_in
      if logged_in?
        redirect "/users/#{current_user.id}"
      end

      #def redirect_if_logged_in_as_someone_else
      #end
    end
  end
end