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
    if logged_in?
      redirect "/users/#{current_user.id}"
    else
    erb :welcome
  end

  helpers do 

    def logged_in?
      !!current_user
      #a value and returns boolean reflection of its truthiness
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
   # use this helper method to protect controller actions where user must be logged in to proceed
   def authorized_to_edit?(journal_entry)
    journal_entry.user == current_user
  end
   
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
