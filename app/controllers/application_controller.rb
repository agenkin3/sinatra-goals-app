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
    erb :welcome
  end

end
