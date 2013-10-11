require 'spec_helper'


describe TicketsController do

  describe "#create" do

    context "user is not logged in" do
      before do
        session[:user_id] = nil
      end

      it "should redirect back to home" do
        expect{ post :create }.to redirect_to('/')
      end
      it "should not create a new ticket" do
        expect{ post :create }.not_to change{Ticket.count}
      end

    end

    context "user is logged in" do
      before do
        @user = User.create!(email: "email@email.com")
        session[:user_id] = @user.id
      end

      it "should redirect back to the homepage upon successful ticket creation" do
        expect{ post :create, { location: "damen and montrose" } }.to redirect_to(:root)
      end

      it "should redirect back to the homepage with errors if ticket creation fails" do

      end
    end
  end

end
