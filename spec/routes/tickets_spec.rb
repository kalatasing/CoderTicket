# spec/routes/tickets_spec.rb
require 'rails_helper'

## TICKETs ##

RSpec.describe "tickets" do

  it ".events/event_id/tickets/new" do
    expect(get: "events/1/tickets/new").to route_to('tickets#new', event_id: "1")
  end

end