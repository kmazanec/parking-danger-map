require 'spec_helper'

describe "Homepage" do

  describe "the signup process",  type: :feature do

    context'with blank password' do
      it 'should come back to sign up page' do 
        visit signup_path
        sign_up_with 'betsy@gmail.com', '', ''

        expect(page).to have_content('Create new user')
      end
    end

    context 'with wrong password confirmation' do
      it 'should come back to sign up page' do 
        visit signup_path
        sign_up_with 'betsy@gmail.com', 'one', 'two'

        expect(page).to have_content('Create new user')
      end
    end

    context 'with valid email and password' do
      it 'should bring user to their login page' do 
        visit signup_path
        sign_up_with 'betsy@gmail.com', 'one', 'one'

        expect(page).to have_content('betsy@gmail.com')
      end

    end



  end


end
