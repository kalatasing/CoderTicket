require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  before (:each) do
    @a = Event.new(name: "Event A", starts_at: 1.day.from_now)
    @b = Event.new(name: "Event B", starts_at: (Time.now + 60))
    @c = Event.new(name: "Event C", starts_at: (Time.now - 10))
    @a.save(validate: false)
    @b.save(validate: false)
    @c.save(validate: false)
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
      #expect(assigns(:events)).not_to match_array([@c])
    end

    it "Search event return corect data" do
      get 'index', search: "a"
      expect(assigns(:events)).to match_array(@a)
      expect(assigns(:events)).not_to match_array(@b)
    end

    it 'Return root path if there is no event in future' do
      controller.instance_variable_set(:@events, nil)
      get 'index'
      expect(assigns(:events)).to render_template('index')
    end

  end

  describe "show" do
    it 'Return event detail show page OK' do
      get 'show', id: @a.id
      expect(response).to have_http_status(200)
    end

    it 'Return show.html.erb' do
      get 'show', id: @a.id
      expect(response).to render_template('show')
    end

    it 'Return show.html.erb with correct data' do
      get 'show', id: @a.id
      expect(assigns(:event)).to eql(@a)
    end
  end


end
