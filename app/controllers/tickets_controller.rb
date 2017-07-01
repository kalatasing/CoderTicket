class TicketsController < ApplicationController
  def new
    @event = Event.find_by_id(params[:event_id])
    redirect_to root_path if @event.nil?
  end
end
