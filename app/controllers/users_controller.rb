class UsersController < ApplicationController

 
get '/login' do
  erb :login
end

post '/login' do
 
  if @user = User.find_by(email: params[:email])
    if @user.authenticate(params[:password])
    session[:user_id] = @user.id
    puts session
    redirect "users/#{@user.id}"
    else 
      erb :signup
    end
  else 
    erb :signup
  end
end

  get '/signup' do
    erb :signup
  end

  post '/users' do
  if params[:name] != "" && params[:email] != "" && params[:password] != "" 
  @user=User.create(params) 
  session[:user_id] = @user.id #logs the user in 
  # go to the user show page
  redirect "/users/#{@user.id}"

else 
    #if not valid input, take them back to signup 
redirect '/signup'
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
