class GoalEntriesController < ApplicationController
  
  #get goal_entries/new to render a form to create new one
  get '/goal_entries' do
  #   @goal_entries = GoalEntry.all
  erb :'goal_entries/index'
  end

    # get goal_entries/new to render a form to create new entry
    #show the new page or render the form
    get '/goal_entries/new' do
      redirect_if_not_logged_in
      erb :'/goal_entries/new'
    end

    #post goal_entries to create a new journal entry 
    post '/goal_entries' do
      #only want to create new entry if user is logged in 
      if !logged_in?
        redirect '/'
      end

      if params[:content] != ""
        #create a new entry
        @journal_entry = JournalEntry.create(content:params[:content],user_id: current_user.id)
      else
        redirect '/journal_entries_new'

    end
    #doesnt render anything
    #create a new journal entry and save it to DB 


    #show page for a journal entry
    get '/show' do
      erb :'goal_entries/show'
    #index route for all journal entries

end
end
