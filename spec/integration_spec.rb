require('capybara/rspec')
require('./app')
require('pry')
require('spec_helper')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('path to creating a family tree', {:type => :feature}) do
  it('allows user to start a family tree') do
    visit('/')
    click_link('Start family tree')
    fill_in('name', :with => 'Bob')
    fill_in('gender', :with => 'male')
    click_button('Start Tree')
    expect(page).to have_content('Bob')
  end
end

describe('adding a child to a person', {:type => :feature}) do
  it('lets a user choose a child for a person and displays it on the family tree') do
    bob = Person.create(name:'Bob', gender: 'male', is_top: true)
    visit("/#{bob.id}/edit")
    fill_in('child_name', :with => "john")
    choose('child_male')
    fill_in('spouse_name', :with => "sally")
    choose('spouse_female')
    click_button('Add Child')
    click_link("#{bob.name}")
    expect(page).to(have_content("john"))
    expect(page).to(have_content("sally"))
  end
end
