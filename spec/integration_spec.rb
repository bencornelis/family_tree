require('capybara/rspec')
require('./app')
require('pry')
require('spec_helper')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('path to creating a family tree', {:type => :feature}) do
  it('allows user to start a family tree') do
    visit('/')
    click_link('Start new family tree')
    fill_in('name', :with => 'Bob')
    click_button('Start Tree')
    expect(page).to have_content('Bob')
  end
end

describe('adding a child to a person', {:type => :feature}) do
  it('lets a user choose a child for a person and displays it on the family tree') do
    bob = Person.create(name:'Bob', tree_top: true)
    visit("/#{bob.id}/edit")
    fill_in('child_name', :with => "john")
    fill_in('spouse_name', :with => "sally")
    click_button('Add relationship')
    click_link("#{bob.name}")
    expect(page).to(have_content("John"))
    expect(page).to(have_content("Sally"))
  end
end
