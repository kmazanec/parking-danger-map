require 'spec_helper'


describe TicketsController do

  describe "#create" do

    context "user is not logged in" do
      before do
        session[:user_id] = nil
      end

      it "should redirect back to home" do
        post :create
        expect(response).to redirect_to('/')
      end
      it "should not create a new ticket" do
        expect{ post :create }.not_to change{Ticket.count}
      end

    end

    context "user is logged in" do
      before do
        @user = User.create!(email: "email@email.com", password: "test", password_confirmation: "test")
        session[:user_id] = @user.id
      end

      let(:dummy_ticket){ {ticket: {fine: 50}, location: "damen and montrose"} }

      it "should redirect back to the homepage upon successful ticket creation" do
        post :create, dummy_ticket
        expect(response).to redirect_to(:root)
      end

      it "should create a new ticket" do
        expect{ post :create, dummy_ticket }.to change{Ticket.count}
      end

      it "should redirect back to the homepage with errors if ticket creation fails" do
        post :create, {}
        expect(flash[:notice]).not_to eq(nil)
      end
    end
  end

end
