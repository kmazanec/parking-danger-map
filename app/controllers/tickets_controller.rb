class TicketsController < ApplicationController

  def create

    if !logged_in?
      redirect_to :root
    else
      begin
        ticket = current_user.tickets.build(ticket_params)
        ticket.location = Location.create(user_submission: params[:location])
        current_user.save!
      rescue ActionController::ParameterMissing
        flash[:notice] = "Invalid parameters"
      ensure
        redirect_to :root
      end
    end

  end

  def update
    if !logged_in?
      redirect_to :root
    else
      begin
        @ticket = current_user.tickets.find(params[:id])
        @ticket.update_attributes(update_params)
      rescue ActiveRecord::RecordNotFound
        flash[:notice] = "We were not able to find that record. Please try again"
      ensure
        redirect_to (user_path(current_user))
      end
    end
  end

  def destroy
    if !logged_in?
      redirect_to :root
    else
      begin
        @ticket = current_user.tickets.find(params[:id])
        @ticket.destroy
      rescue ActiveRecord::RecordNotFound
        flash[:notice] = "We were not able to find that record. Please try again"
      ensure
        redirect_to (user_path(current_user))
      end
    end
  end

  private

  def ticket_params
    params.require(:ticket).permit(:fine, :officer, :issued_at, :status)
  end

  def update_params
    params.require(:ticket).permit(:status)
  end

end
