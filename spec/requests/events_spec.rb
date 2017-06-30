require 'rails_helper'

RSpec.describe "Events", type: :request do
  before (:each) do
    @a = Event.new(name: "Event A", starts_at: 1.day.from_now)
    @b = Event.new(name: "Event B", starts_at: (Time.now + 60))
    @a.save(validate: false)
    @b.save(validate: false)
  end

  describe "Search function" do
    it "Return all events if search value is NULL" do
      get root_path(search: nil)
      expect(assigns(:events)).to match_array([@a, @b])
    end

    it "Return NO events if search value is not valid" do
      get root_path(search: "no_value")
      expect(assigns(:events)).to match_array([])
    end

    it "Return all events contains search value" do
      get root_path(search: "event")
      expect(assigns(:events)).to match_array([@a, @b])
    end

    it "Return correct event for search" do
      get root_path(search: "a")
      expect(assigns(:events)).to match_array([@a])
      expect(assigns(:events)).not_to match_array([@b])
    end
  end

end
