# spec/routes/events_spec.rb
require 'rails_helper'

## EVENTs ##
RSpec.describe "events", type: :routing do
  it ".upcoming" do
    expect(get: "/upcoming").to route_to(controller: "events", action: "index")
  end

  it ".event/event_id" do
    expect(get: "events/1").to route_to('events#show', id: "1")
  end
end


