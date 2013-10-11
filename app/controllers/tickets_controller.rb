class TicketsController < ApplicationController

  def create

    # p params[:location]
    # p params[:email]
    # p params[:ticket]

    if !logged_in?
      redirect_to :root
    else
      ticket = current_user.tickets.build(ticket_params)
      ticket.location = Location.create(user_submission: params[:location])
      current_user.save!
      redirect_to :root
    end

    # If already logged in
      # use current user
    # Else if email present in form
      # Find or create user by email
    # Else if session user id exists
      # find the user with that id
    # Else
      # create a new anonymous user
      # save user id in session


    # # @new_ticket = Ticket.create(ticket_params)

  end

  private

  def ticket_params
    params.require(:ticket).permit(:fine, :officer, :issued_at, :status)
  end

end
