class TicketsController < ApplicationController

  def create
    p params[:location]
    p params[:email]
    p params[:ticket]
    @new_ticket = Ticket.create(ticket_params)
    redirect_to user_path(@user)
  end

  private

  def ticket_params
    params.require(:ticket).permit(:fine, :officer, :issued_at, :status)
  end

end