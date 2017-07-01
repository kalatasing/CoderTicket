class TicketsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def new
    @event = Event.find_by_id(params[:event_id])
    redirect_to root_path if @event.nil?
  end

  def create

  end

  def validate_ticket

  end

end
