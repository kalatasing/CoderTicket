require 'rails_helper'

RSpec.describe "events/show", type: :view do
  it "Render OK for event detail page if event exist" do

    event = Event.create!(name: "Michael Jackson", starts_at: 2.days.from_now, ends_at: 3.day.from_now, extended_html_description: " a future event",
                          venue: Venue.new, category: Category.new)
    assign(:event, event)
    render
    expect(rendered).to include('<h3> Michael Jackson </h3>')
    expect(rendered).to have_css('button', text: "BOOK NOW")
  end
end

