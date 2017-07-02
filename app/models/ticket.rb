class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :event
  belongs_to :ticket_type

  def self.ticket_validate(event, ticket_type_id, number_of_order)
    tickets = Ticket.where(event_id: event.id)
                    .where(ticket_type_id: ticket_type_id)

    max_quantity = event.ticket_types.find(ticket_type_id).max_quantity

    available = max_quantity - tickets.count
    return (number_of_order <= available)
  end
end
