class Employee < ApplicationRecord
  belongs_to :department
  has_many :employee_tickets
  has_many :tickets, through: :employee_tickets

  def tickets_old_to_new
    self.tickets.order(age: :desc)
  end

  def oldest_ticket
    self.tickets_old_to_new.first
  end

  def best_friends
    employee_ticket_ids = self.ticket_ids

    tickets = Ticket.where(id: employee_ticket_ids)

    friends = []

    tickets.each do |ticket|
      friends << ticket.employees
    end
    
    friends.flatten.uniq
  end

end