require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

# in order to send PATCH and DELETE requests, the line of code below
use Rack:: MethodOverride

# where I will mount other controllers with 'use'
run ApplicationController
