class EventsController < ApplicationController
  def index
    if params[:search]
      @events = search_event
    else
      @events = Event.all
    end

  end

  def show
    @event = Event.find(params[:id])
  end

  def search_event
    @events = Event
                 .where('lower(name) like ? OR lower(extended_html_description) like ?', "%#{params[:search].downcase}%","%#{params[:search].downcase}%")
                 .where("starts_at > ?", Time.now)
  end

end
