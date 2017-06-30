require 'rails_helper'

RSpec.describe Event, type: :model do

  describe '.upcoming' do
    it "Return only event in future" do
      a = Event.new(name: "Event A", starts_at: 1.day.from_now)
      a.save(validate: false)
      expect(Event.upcoming).to match_array([a])
    end

    it "Return NO EVENTs in the past" do
      a = Event.new(name: "Event A", starts_at: 1.day.ago)
      a.save(validate: false)
      expect(Event.upcoming).not_to match_array([a])
    end

    it "Return correct events in list of events" do
      a = Event.new(name: "Event A", starts_at: 1.day.from_now)
      b = Event.new(name: "Event B", starts_at: 1.day.ago)
      c = Event.new(name: "Event C", starts_at: (Time.now + 60))
      d = Event.new(name: "Event D", starts_at: (Time.now - 60))
      a.save(validate: false)
      b.save(validate: false)
      c.save(validate: false)
      d.save(validate: false)
      expect(Event.upcoming).to match_array([a,c])
    end


  end

end
