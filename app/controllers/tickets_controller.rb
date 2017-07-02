class TicketsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def new
    @event = Event.find_by_id(params[:event_id])
    redirect_to root_path if @event.nil?
  end

  def create
    if validate_ticket
      process_tickets
      flash[:success] = "Tickets has been created successful..."
      redirect_to events_path
    else
      flash[:error] = "Not enough ticket available"
      redirect_to :back
    end
  end

  def validate_ticket
    event = Event.find_by_id(params[:event_id])
    types = event.ticket_types

    types.each do |i|
      quantity = "quantity_for_#{i.id}".intern
      return Ticket.ticket_validate(event,i.id,params[quantity].to_i)
    end
  end

  def process_tickets
    event = Event.find_by_id(params[:event_id])
    types = event.ticket_types

    types.each do |i|
      param_text = "quantity_for_#{i.id}".intern
      quantity = params[param_text].to_i

        (1..quantity).each do
        Ticket.create!(
            user_id: params[:user_id],
            event_id: params[:event_id],
            ticket_type_id: i.id,
            venue_id: nil,
        )
        end
      end
  end



end
