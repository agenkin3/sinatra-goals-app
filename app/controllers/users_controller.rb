class UsersController < ApplicationController

get '/login' do
  erb :login
end

post '/login' do
 #find the user 
   @user = User.find_by(email: params[:email]) 
    if @user && @user.authenticate(params[:password])
    session[:user_id] = @user.id
    redirect "users/#{@user.id}"
    #authenticate the user
    #send them to user landing page 
  else 
    redirect '/login' 
  end
end

  get '/signup' do
    erb :signup
  end

  post '/users' do
  if params[:name] != "" && params[:email] != "" && params[:password] != "" 
  @user=User.create(params) 
  #creates user and persists to the database
  if @user.save
  session[:user_id] = @user.id #logs the user in 
  # go to the user show page
  redirect "/users/#{@user.id}"
else 
    #if not valid input, take them back to signup 
erb :'/signup'
end
end
end 
  
  #user SHOW route
  get '/users/:id' do
    @user=User.find_by(id: params[:id])
    #can either log them in or send them back to login page
    erb :'/users/show'
  #this will be the user show route
  end

  get '/logout' do
    session.clear
    redirect '/'
  end
  
end
