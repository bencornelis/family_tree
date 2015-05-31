require("bundler/setup")
Bundler.require(:default)
require('sinatra/reloader')

also_reload('lib/**/*.rb')
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }


get '/' do
  @tree_starters = Person.where(tree_top: true)
  erb :index
end

get '/start_tree' do
  erb :start_tree
end

post '/start_tree' do
  name = params["name"]
  Person.create(name: name, tree_top: true)
  redirect '/'
end

get '/viewtree/:id' do |id|
  @tree_starter = Person.find(id)
  erb :view_tree
end

get '/:id/edit' do |id|
  @person = Person.find(id)
  erb :person_edit
end

post '/:person_id/edit' do |person_id|
  person = Person.find(person_id)
  spouse_name = params["spouse_name"].capitalize
  if Person.where(name: spouse_name).any?
    spouse = Person.where(name: spouse_name).first
  else
    spouse = Person.create(name: spouse_name)
  end
  child_name = params["child_name"]
  child = Person.create(name: child_name)
  person.children << child
  spouse.children << child
  redirect "/"
end
