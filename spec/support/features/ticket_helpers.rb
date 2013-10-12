module Features
  module TicketHelpers

    def create_ticket_with(location, date, fine, officer, status, email)
      within("#ticket_form") do
        fill_in 'Location (address or cross street)', with: location
        fill_in 'ticket_issued_at', with: date
        fill_in 'ticket_fine', with: fine
        fill_in 'ticket_officer', with: officer
        select(status, from: 'ticket_status')
        fill_in 'email', with: email
        click_button 'Create Ticket'
      end
    end

  end

end
