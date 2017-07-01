require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  before (:each) do
    @a = Event.new(name: "Event A", starts_at: 1.day.from_now)
    @b = Event.new(name: "Event B", starts_at: (Time.now + 60))
    @a.save(validate: false)
    @b.save(validate: false)
  end

  describe "index" do

    it "Return status OK" do
      get 'index'
      expect(response).to have_http_status(200)
    end

    it "Render index.html.erb" do
      get 'index'
      expect(response).to render_template('index')
    end

    it "Index return correct data" do
      get 'index'
      expect(assigns(:events)).to match_array([@a, @b])
    end
  end
end
