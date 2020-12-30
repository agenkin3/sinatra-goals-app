class GoalEntriesController < ApplicationController
  
  #get goal_entries/new to render a form to create new one
  get '/goal_entries' do
    @goal_entries = GoalEntry.all
    erb :'goal_entries/index'
  end

    # get goal_entries/new to render a form to create new entry
    get '/goal_entries/new' do
      redirect_if_not_logged_in
      erb :'/goal_entries/new'
    end

    #post goal_entries to create a new journal entry 

    #show page for a journal entry

    #index route for all journal entries

end
