require 'rails_helper'

RSpec.describe "tickets/new", type: :view do

  before (:each) do
    @e = Event.create(
        name: "Ticket Test",
        starts_at: 2.days.from_now,
        ends_at: 3.day.from_now,
        extended_html_description: " a future event",
        venue: Venue.new,
        category: Category.new
    )
    @e.save(validate: false)

  end

  it "Return tickets book form" do
    assign(:event, @e)
    render
    expect(rendered).to  match("<h3> Ticket Test </h3>")
    expect(rendered).to have_css('button', text: "Buy")
  end

end
