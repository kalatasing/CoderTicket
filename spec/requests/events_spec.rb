require 'rails_helper'

RSpec.describe "Events", type: :request do
  before (:each) do
    @venue = Venue.new(name: "Ho Chi Minh")
    @venue.save(validate: false)
    @a = Event.new(name: "Event A", starts_at: 1.day.from_now, venue_id: @venue.id, extended_html_description: "Rspec")
    @b = Event.new(name: "Event B", starts_at: (Time.now + 60))
    @a.save(validate: false)
    @b.save(validate: false)
  end

  describe "Search function" do
    it "GET events/search= with NULL value for search" do
      get root_path(search: nil)
      expect(assigns(:events)).to match_array([@a, @b])
    end

    it "GET events/search=no_value with invalid search text" do
      get root_path(search: "no_value")
      expect(assigns(:events)).to match_array([])
    end

    it "GET events/search=event" do
      get root_path(search: "event")
      expect(assigns(:events)).to match_array([@a, @b])
    end

    it "GET events/search=a" do
      get root_path(search: "a")
      expect(assigns(:events)).to match_array([@a])
      expect(assigns(:events)).not_to match_array([@b])
    end
  end

  describe "GET events/id with valid event id" do
    it "Return event details page" do
      get event_path(@a.id)
      expect(assigns(:event)).to eql(@a)
    end

    it "GET events/0000 with invalid event id" do
      get event_path(id: 0000)
      expect(assigns(:event)).to eql(nil)
    end

  end


end
