require 'spec_helper'

describe "Home Page" do

  before(:each) do
    visit root_path
  end

  it 'should show the home page map' do
    page.should have_content "Location"
  end

   it "Has a create a ticket button" do
      click_button 'Create Ticket'
      page.should have_content 'Location'
  end


describe "user creates a ticket" do
  it "successfully creates ticket" do
    visit root_path
    fill_in "Location", with: "state and lake"
    fill_in "When did they write this ticket?", with: "10-11-2013"
    select 'Unpaid', :from => 'What is the status of your ticket?'
    click_button 'Create Ticket'
  end
end


end
