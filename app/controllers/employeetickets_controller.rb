class EmployeeticketsController < ApplicationController

  def create
    ticket = Ticket.find(params[:ticket_id])
    employee = Employee.find(params[:employee_id])

    EmployeeTicket.create(employee: employee, ticket: ticket)

    redirect_to "/employees/#{employee.id}"
  end

end