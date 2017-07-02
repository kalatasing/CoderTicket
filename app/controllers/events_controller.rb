class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:create]


  def index
    if params[:search]
      @events = search_event
    else
      @events = Event.upcoming
    end

  end

  def show
    @event = Event.find_by_id(params[:id])
    redirect_to root_path if @event.nil?
  end

  def search_event
    @events = Event
                 .where('lower(name) like ? OR lower(extended_html_description) like ?', "%#{params[:search].downcase}%","%#{params[:search].downcase}%")
                 .where("starts_at >= ?", Time.now)
  end

  def create
    # starts_at = DateTime.parse(params[:start].values[0])
    # ends_at = DateTime.parse(params[:end].values[0])
    # new_event = Event.new(
    #                name: params[:name],
    #                category_id: params[:category_id],
    #                venue_id: params[:venue_id],
    #                hero_image_url: params[:hero_image_url],
    #                extended_html_description: params[:description],
    #                starts_at: starts_at,
    #                ends_at: ends_at,
    #                user_id: params[:user_id]
    #       )
    # new_event.save!
    # render events_path


    @event = current_user.events.build(event_params)

    if @event.save
      flash[:success] = "Event created successfull!"
      redirect_to root_path
    else
      flash[:error] = @event.errors.full_messages
      render 'new'
    end

  end

  def event_params
    params.require(:event).permit(:name, :hero_image_url, :extended_html_description, :category_id, :venue_id, :starts_at, :ends_at, :user_id)
  end

end
