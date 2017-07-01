class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.integer :user_id
      t.integer :event_id
      t.integer :ticket_type_id
      t.integer :venue_id
      t.boolean :public

      t.timestamps
    end
  end
end
