require 'spec_helper'


describe TicketsController do

  context "routing" do
    it "routes /tickets "

  end


  describe "#create" do
    before do
      @location = Location.create!(user_submission: "Damen and Montrose")
      @ticket = Ticket.create!(fine: 50,
                              officer: "Taco",
                              issued_at: "2013-10-10".to_date,
                              status: "Unpaid")
    end

  end

  context "when logged in as a verifed user" do

    before do
      sign_in_as user
    end


  end

  context "when identified as an anonymous user with an existing session" do


  end

  context "when no session yet exists" do


  end


end
