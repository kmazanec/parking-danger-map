require 'spec_helper'

describe "Profile Page" do

  context 'with a user signed in' do 
    before :each do
      @user = User.create({email: 'test@mail.com', password: 'test', password_confirmation: 'test'})
      visit root_path
      log_in_with 'test@mail.com', 'test'
    end

    context 'with no tickets for this user' do
      it "shows a 'no created tickets' message" do
        visit user_path(@user)
        expect(page).to have_content("You currently do not have any tickets")
      end

      it "has a link to create a new ticket" do
        visit user_path(@user)
        expect(page).to have_selector("a", text: "Create a new ticket!")
      end
    end

    context 'with tickets associated' do
      before do
        visit root_path
        create_ticket_with('East 74th Street and Lexington Ave', '10/10/2013', '100', 'Officer Taco', 'Unpaid', @user.email)
        create_ticket_with('East 74th Street and Park Ave', '10/09/2013', '75', 'Officer Taco', 'Unpaid', @user.email)
      end

      it 'lists out two tickets' do
        visit user_path(@user)
        expect(page).to have_css(".ticket", count: 2)
      end

      context 'displays ticket information' do
        before do
          visit user_path(@user)
        end

        it 'displays the ticket location' do
          expect(page).to have_content('Ticket Location: East 74th Street and Park Ave')
        end

        it 'displays the ticket date' do
          expect(page).to have_content('Date Issued: 10/10/2013')
        end

        it 'displays the ticket fine amount' do
          expect(page).to have_content('Fine Amount: $100')
        end

        it 'displays the ticket issuing officer' do
          expect(page).to have_content('Issuing Officer: Officer Taco')
        end

        it 'displays the ticket status' do
          expect(page).to have_content('Ticket Status: Unpaid')
        end

      end
    end
  end




  context 'with no user signed in' do
    it "shows the homepage with an error message" do
      visit user_path(3)
      expect(page).to have_content("Please log in")
    end
  end


  

end




  # context "no user is signed in" do
  #   before(:each) do
  #    visit root_path

  #   end

  #   it "should redirect to the homepage" do
  #     page.should have_selector('div')
  #   end

  #   describe "Deny Profile Access" do
  #     it "shouldn't be able click on Profile Link" do
  #       page.should_not have_content "Profile"
  #     end

  #     it "redirect when trying to edit a profile" do
  #       visit show_user(User.first)
  #       page.should have_content "Error"
  #     end
  #   end
  # end

  # context "signed in" do
  #   describe "current user tries to visit someone else's profile"
    

  #   describe "when a user visits their profile page" do

  #   end
  # end
