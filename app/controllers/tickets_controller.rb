class TicketsController < ApplicationController

  def create

    if !logged_in?
      redirect_to :root
    else
      begin
        ticket = current_user.tickets.build(ticket_params)
        ticket.location = Location.create(user_submission: params[:location])
        puts ticket.location
        current_user.save!
      rescue ActionController::ParameterMissing
        flash[:notice] = "Invalid parameters"
      ensure
        redirect_to :root
      end
    end

  end

  def update
    redirect_to "http://www.google.com"
    # if !logged_in?
    #   redirect_to :root
    # else
    #   begin
    #     ticket = current_user.tickets.find()
    #   end
    # end
  end

  private

  def ticket_params
    params.require(:ticket).permit(:fine, :officer, :issued_at, :status)
  end

end
