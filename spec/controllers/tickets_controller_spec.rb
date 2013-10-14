require 'spec_helper'


describe TicketsController do

  describe "#create" do

    context "when user is not logged in" do
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

    context "when user is logged in" do
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


  describe "#update" do
    let(:location) {FactoryGirl.create(:location, id: 1)}
    let(:user) {FactoryGirl.create(:user, id: 1) }
    let(:user2) {FactoryGirl.create(:user, id: 2)}
    let(:test_ticket) { FactoryGirl.create(:ticket, user_id: user.id, id: 1) }
    let(:invalid_session){ user2.id }
    let(:valid_session) { user.id }


    context "when user is not logged in" do
      before do
        session[:user_id] = nil
        put :update, id: test_ticket
      end

      it "redirects back to home" do
        expect(response).to redirect_to('/')
      end

      it "sets the flash error" do
        expect(flash[:notice]).to eq("Please log in or sign up in order to view that page.")
      end

    end

    context "when user is logged in" do
      before do
        session[:user_id] = valid_session
      end

      context "when attributes are valid" do

        it "updates the ticket attributes" do
          expect { 
            put :update, id: test_ticket.id, ticket: {status: "paid"} 
            test_ticket.reload.status
          }.to change(test_ticket, :status).to("paid")
        end

        it "redirects to user profile page" do
          put :update, id: test_ticket, ticket: {status: "paid"}
          expect(response).to redirect_to(user_path(user))
        end

      end
    
    end

  end

  describe "#delete" do
    let(:location) {FactoryGirl.create(:location, id: 1)}
    let(:user) {FactoryGirl.create(:user, id: 1) }
    let(:user2) {FactoryGirl.create(:user, id: 2)}
    let(:test_ticket) { FactoryGirl.create(:ticket, user_id: user.id, id: 1) }
    let(:invalid_session){ user2.id }
    let(:valid_session) { user.id }


    context "when user is not logged in" do
      before do
        session[:user_id] = nil
        delete :destroy, id: test_ticket
      end

      it "redirects back to home" do
        expect(response).to redirect_to('/')
      end

      it "sets the flash error" do
        expect(flash[:notice]).to eq("Please log in or sign up in order to view that page.")
      end

    end

    context "when user is logged in" do
      before do
        session[:user_id] = valid_session
      end

      context "when attributes are valid" do

        it "deletes the ticket from the database" do
          test_ticket
          expect { 
            delete :destroy, id: test_ticket
          }.to change{Ticket.count}.by(-1)
        end

        it "redirects to user profile page" do
          delete :destroy, id: test_ticket
          expect(response).to redirect_to(user_path(user))
        end

      end

    end

  end

end
