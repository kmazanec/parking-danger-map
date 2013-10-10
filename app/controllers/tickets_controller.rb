class TicketsController < ApplicationController

  def create
    # p params[:location]
    # p params[:email]
    # p params[:ticket]

    if true#!logged_in?
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

    # current_user.tickets.build(ticket_params)
    # # @new_ticket = Ticket.create(ticket_params)
    # redirect_to user_path(current_user)
  end

  private

  def ticket_params
    params.require(:ticket).permit(:fine, :officer, :issued_at, :status)
  end

end
