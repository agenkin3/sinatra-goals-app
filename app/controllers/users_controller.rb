class UsersController < ApplicationController
  
get '/login' do
  redirect_if_logged_in
  erb :login
end

# get '/users' do
#   erb :signup
# end

#the purpose of this route is to receive the login form, find hte user, and log the user in (create a session)
post '/login' do
 #find the user 
  @user = User.find_by(email: params[:email]) 
  if @user && @user.authenticate(params[:password])
    # SET sessions[:user_id] value here
    # session[:user_id] = 1
    # x = 1
    session[:user_id] = @user.id
    flash[:message] = "Welcome, #{@user.name}!"
    redirect "users/#{@user.id}"
    #authenticate the user
    #send them to user landing page 
  else 
    flash[:errors] = "Your credentials were invalid.  Please sign up or try again."
    redirect '/login' 
  end
end

get '/signup' do
  erb :signup
end

post '/users' do
  #create the user and persist the user to the database
  @user=User.create(params) 
  #creates user and persists to the database
  if @user.save
    session[:user_id] = @user.id #logs the user in 
    # go to the user show page
    redirect "/users/#{@user.id}"
  else  
    #if not valid input, take them back to signup 
    flash[:errors] = "Your credentials were invalid.  Please sign up or try again."
    redirect '/signup'
  end
end 
  
#user SHOW route
get '/users/:id' do
  redirect_if_not_logged_in
  @user=User.find_by(id: params[:id])
  if current_user.id != @user.id
    flash[:errors] = "You are not authorized! Get out."
    redirect "users/#{current_user.id}"
  else
  #can either log them in or send them back to login page
  erb :'/users/show'
  end
end

get '/logout' do
  session.clear
  redirect '/'
end
  
end
