require 'rails_helper'

RSpec.describe Ticket, type: :model do
  before(:each) do
    @e = Event.create(name: "Test Event")
    @e.save(validate: false)
    @type = @e.ticket_types.create(max_quantity: 2)
    @type.save(validate: false)
  end

  describe "validate_ticket function" do
    it 'Return failed if no available tickets' do
      expect(Ticket.ticket_validate(@e,@type.id,3)).to eql(false)
    end

    it 'Return true if there is no ticket to buy' do
      expect(Ticket.ticket_validate(@e,@type.id,0)).to eql(true)
    end

    it 'Return true if there is enough available tickets' do
      expect(Ticket.ticket_validate(@e,@type.id,1)).to eql(true)
      expect(Ticket.ticket_validate(@e,@type.id,2)).to eql(true)
    end
  end

end
