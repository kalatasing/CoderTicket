require 'rails_helper'

RSpec.describe "events/index", type: :view do

  it "renders Discover upcoming events in a header tag" do
    assign(:events, [])
    render
    expect(rendered).to include("<h2> Discover upcoming events </h2>")
  end

  it "Display an event title" do
    event = Event.create!(name: "Michael Jackson", starts_at: 2.days.from_now, ends_at: 3.day.from_now, extended_html_description: " a past event",
                          venue: Venue.new, category: Category.new)
    assign(:events, [event])
    render
    expect(rendered).to include('<h4 class="card-title">Michael Jackson</h4>')
    expect(rendered).to have_css(".col-md-6", count: 1)
  end

  it "Display search textbox" do
    assign(:events, [])
    render
    expect(rendered).to have_css("input[name='search']", match(placeholder="Search for events, shows, courses..."))
  end

  it "Display search button" do
    assign(:events, [])
    render
    expect(rendered).to have_css("input[name='commit']", match(value = "search"))
  end

  it "Render OK when there's upcoming events" do
    event = Event.create(name: "test")
    event.save(validate: false)
    assign(:events, [event])
    render
    expect(rendered).to have_css(".container-fluid events-list", count: 0)
  end

end
