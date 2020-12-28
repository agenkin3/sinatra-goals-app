require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions #???
    set:session_secret, "goals_app"
    #extra layer of security
  end

  get "/" do
    redirect '/login'
  end

  helpers do 

    def logged_in?
      !!current_user
      #takes a value and returns boolean reflection of its truthiness
    end

    def current_user
      @current_user ||= User.find_by[id: session[:user_id]]
      #if find doesn't return what it's looking for it returns error which is why we use find_by
     #find_by is an activerecord method that is going to query the database
     #using @ reduces the number of database calls
     #or equals || will create and assign if the current user is found
    end
    #helpers are available through views and controllers
  end 
end
