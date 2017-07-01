require 'rails_helper'

RSpec.describe "Tickets", type: :request do

c

  describe "GET /events/event_id/tickets/new" do
    it "Return ticket order form correctly" do
      get new_event_ticket_path(event_id: @e.id)
      expect(response).to have_http_status(200)
    end
  end

end
