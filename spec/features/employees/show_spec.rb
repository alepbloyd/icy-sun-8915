require 'rails_helper'

RSpec.describe "the employee show page" do

  it 'displays the employee name and department' do
    department_1 = Department.create!(name: "Technology", floor: 1)

    employee_1 = Employee.create!(name: "Alex", level: 6, department_id: department_1.id)
    employee_2 = Employee.create!(name: "Kate", level: 7, department_id: department_1.id)

    ticket_1 = Ticket.create!(subject: "What is a computer",age: 10)
    ticket_2 = Ticket.create!(subject: "Fix my printer",age: 3)
    ticket_3 = Ticket.create!(subject: "Where is my chair",age: 1)
    ticket_4 = Ticket.create!(subject: "Keyboard filled with snakes",age: 20)

    ticket_5 = Ticket.create!(subject: "I am hungry",age: 2)
    ticket_6 = Ticket.create!(subject: "Soups on!",age: 8)

    et1 = EmployeeTicket.create!(employee: employee_1, ticket: ticket_1)
    et2 = EmployeeTicket.create!(employee: employee_1, ticket: ticket_2)
    et3 = EmployeeTicket.create!(employee: employee_1, ticket: ticket_3)
    et4 = EmployeeTicket.create!(employee: employee_1, ticket: ticket_4)

    visit "/employees/#{employee_1.id}"

    expect(page).to have_content("Name: Alex")
    expect(page).to have_content("Department: Technology")
  end

  it 'displays a list of assigned tickets from oldest to youngest' do
    department_1 = Department.create!(name: "Technology", floor: 1)

    employee_1 = Employee.create!(name: "Alex", level: 6, department_id: department_1.id)
    employee_2 = Employee.create!(name: "Kate", level: 7, department_id: department_1.id)

    ticket_1 = Ticket.create!(subject: "What is a computer",age: 10)
    ticket_2 = Ticket.create!(subject: "Fix my printer",age: 3)
    ticket_3 = Ticket.create!(subject: "Where is my chair",age: 1)
    ticket_4 = Ticket.create!(subject: "Keyboard filled with snakes",age: 20)

    ticket_5 = Ticket.create!(subject: "I am hungry",age: 2)
    ticket_6 = Ticket.create!(subject: "Soups on!",age: 8)

    et1 = EmployeeTicket.create!(employee: employee_1, ticket: ticket_1)
    et2 = EmployeeTicket.create!(employee: employee_1, ticket: ticket_2)
    et3 = EmployeeTicket.create!(employee: employee_1, ticket: ticket_3)
    et4 = EmployeeTicket.create!(employee: employee_1, ticket: ticket_4)

    et5 = EmployeeTicket.create!(employee: employee_2, ticket: ticket_5)
    et6 = EmployeeTicket.create!(employee: employee_2, ticket: ticket_6)

    visit "/employees/#{employee_1.id}"

    within "#assigned-ticket-1" do
      expect(page).to have_content("Ticket Subject: Keyboard filled with snakes")
      expect(page).to have_content("Ticket Age: 20")
    end

    within "#assigned-ticket-2" do
      expect(page).to have_content("Ticket Subject: What is a computer")
      expect(page).to have_content("Ticket Age: 10")
    end

    within "#assigned-ticket-3" do
      expect(page).to have_content("Ticket Subject: Fix my printer")
      expect(page).to have_content("Ticket Age: 3")
    end

    within "#assigned-ticket-4" do
      expect(page).to have_content("Ticket Subject: Where is my chair")
      expect(page).to have_content("Ticket Age: 1")
    end

    expect(page).to_not have_content("I am hungry")
    expect(page).to_not have_content("Soups on!")

  end

  it 'displays the oldest ticket assigned to the employee separately' do
    department_1 = Department.create!(name: "Technology", floor: 1)

    employee_1 = Employee.create!(name: "Alex", level: 6, department_id: department_1.id)
    employee_2 = Employee.create!(name: "Kate", level: 7, department_id: department_1.id)
    employee_3 = Employee.create!(name: "Kiara", level: 8, department_id: department_1.id)

    ticket_1 = Ticket.create!(subject: "What is a computer",age: 10)
    ticket_2 = Ticket.create!(subject: "Fix my printer",age: 3)
    ticket_3 = Ticket.create!(subject: "Where is my chair",age: 1)
    ticket_4 = Ticket.create!(subject: "Keyboard filled with snakes",age: 20)

    ticket_5 = Ticket.create!(subject: "I am hungry",age: 2)
    ticket_6 = Ticket.create!(subject: "Soups on!",age: 8)

    et1 = EmployeeTicket.create!(employee: employee_1, ticket: ticket_1)
    et2 = EmployeeTicket.create!(employee: employee_1, ticket: ticket_2)
    et3 = EmployeeTicket.create!(employee: employee_1, ticket: ticket_3)
    et4 = EmployeeTicket.create!(employee: employee_1, ticket: ticket_4)

    et5 = EmployeeTicket.create!(employee: employee_2, ticket: ticket_5)
    et6 = EmployeeTicket.create!(employee: employee_2, ticket: ticket_6)

    visit "/employees/#{employee_1.id}"

    within "#oldest-ticket" do
      expect(page).to have_content("Oldest Ticket: Keyboard filled with snakes")
      expect(page).to have_content("Oldest Ticket Age: 20")
    end
  end

  it 'has a form to add a ticket to this employee, and when filled out with the id of an existing ticket, redirects to the employee show page where the ticket is now listed' do

    department_1 = Department.create!(name: "Technology", floor: 1)

    employee_1 = Employee.create!(name: "Alex", level: 6, department_id: department_1.id)

    ticket_1 = Ticket.create!(subject: "What is a computer",age: 10)
    ticket_2 = Ticket.create!(subject: "Fix my printer",age: 3)
    ticket_3 = Ticket.create!(subject: "Where is my chair",age: 1)
    ticket_4 = Ticket.create!(subject: "Keyboard filled with snakes",age: 20)

    ticket_5 = Ticket.create!(subject: "I am hungry",age: 2)
    ticket_6 = Ticket.create!(subject: "Soups on!",age: 8)

    et1 = EmployeeTicket.create!(employee: employee_1, ticket: ticket_1)
    et2 = EmployeeTicket.create!(employee: employee_1, ticket: ticket_2)
    et3 = EmployeeTicket.create!(employee: employee_1, ticket: ticket_3)
    et4 = EmployeeTicket.create!(employee: employee_1, ticket: ticket_4)

    visit "/employees/#{employee_1.id}"

    expect(page).to_not have_content("I am hungry")

    fill_in "ticket_id", with: ticket_5.id

    click_on "Submit"

    expect(current_path).to eq("/employees/#{employee_1.id}")

    within "#assigned-tickets" do
      expect(page).to have_content("I am hungry")
    end

  end

end

# Story 3

# As a user,
# When I visit the employee show page,
# I do not see any tickets listed that are not assigned to the employee
# and I see a form to add a ticket to this movie
# When I fill in the form with the id of a ticket that already exists in the database
# and I click submit
# Then I am redirected back to that employees show page
# and i see the ticket's subject now listed
# (you do not have to test for sad path, for example if the id does not match an existing ticket

# Story 2
# Employee Show

# As a user,
# When I visit the Employee show page,
# I see the employee's name, department
# and a list of all of their tickets from oldest to youngest.
# I also see the oldest ticket assigned to the employee listed separately