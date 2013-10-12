module Features
  module TicketHelpers

    def create_ticket(location, date, fine, officer, status, email)
      within("#ticket_form") do
        fill_in 'Location (address or cross street)', with: location
        fill_in 'issued_at', with: date
        fill_in 'fine', with: fine
        fill_in 'officer', with: officer
        fill_in 'status', status
        fill_in 'email', email
        click_button 'submit'
      end
    end

  end

end
