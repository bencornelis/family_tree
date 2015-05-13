require("bundler/setup")
Bundler.require(:default)
require('sinatra/reloader')

also_reload('lib/**/*.rb')
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }


get '/' do
  @tree_starters = Person.where(is_top: true)

  erb :index
end

get '/start_tree' do
  erb :start_tree
end

post '/start_tree' do
  name = params["name"]
  gender = params["gender"]
  is_top = true
  Person.create(name: name, gender: gender, is_top: true)
  redirect '/'
end

get '/viewtree/:id' do |id|
  @tree_starter = Person.find(id.to_i)
  erb :view_tree
end

get '/:id/edit' do |id|
  @person = Person.find(id.to_i)
  erb :person_edit
end

post '/:person_id/edit' do |person_id|
  person = Person.find(person_id.to_i)
  child = Person.create(name: params.fetch("child_name"), gender: params.fetch("child_gender"))
  child.update_relationship(person, params)
  redirect "/"
end
