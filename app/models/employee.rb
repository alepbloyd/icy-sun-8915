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

end