require 'rails_helper'

RSpec.describe "Tickets", type: :request do

  before (:each) do
    @e = Event.create!(
        name: "Ticket Test",
        starts_at: 2.days.from_now,
        ends_at: 3.day.from_now,
        extended_html_description: " a future event",
        venue: Venue.new,
        category: Category.new
    )
    @e.save(validate: false)
  end

  describe "GET /events/event_id/tickets/new" do
    it "Return ticket order form correctly" do
      get new_event_ticket_path(event_id: @e.id)
      expect(response).to have_http_status(200)
    end
  end

end
