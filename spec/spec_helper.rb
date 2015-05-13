ENV['RACK_ENV'] = 'test'

require("bundler/setup")
Bundler.require(:default, :test)
Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each { |file| require file }


RSpec.configure do |config|
  config.after(:each) do
    Relationship.all().each do |relationship|
      relationship.destroy()
    end
    Person.all().each do |person|
      person.destroy()
    end
  end
end
