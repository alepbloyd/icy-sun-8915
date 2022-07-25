require 'rails_helper'

RSpec.describe "the department index page" do
  
  it 'displays each department\'s name and floor' do

    department_1 = Department.create!(name: "Technology", floor: 1)
    department_2 = Department.create!(name: "Human Resources", floor: 2)
    department_3 = Department.create!(name: "Development", floor: 3)

    visit "/departments"

    within "#department-#{department_1.id}" do
      expect(page).to have_content("Name: Technology")
      expect(page).to have_content("Floor: 1")
    end

    within "#department-#{department_2.id}" do
      expect(page).to have_content("Name: Human Resources")
      expect(page).to have_content("Floor: 2")
    end

    within "#department-#{department_3.id}" do
      expect(page).to have_content("Name: Development")
      expect(page).to have_content("Floor: 3")
    end

  end

  it 'displays each department\'s employees' do

    department_1 = Department.create!(name: "Technology", floor: 1)
    department_2 = Department.create!(name: "Human Resources", floor: 2)
    department_3 = Department.create!(name: "Development", floor: 3)

    employee_1 = Employee.create!(name: "Alex", level: 6, department_id: department_1.id)
    employee_2 = Employee.create!(name: "Kate", level: 7, department_id: department_1.id)
    employee_3 = Employee.create!(name: "Kiara", level: 8, department_id: department_1.id)

    employee_4 = Employee.create!(name: "Jeff", level: 1, department_id: department_2.id)
    employee_5 = Employee.create!(name: "Jim", level: 2, department_id: department_2.id)
    employee_6 = Employee.create!(name: "Jeb", level: 3, department_id: department_2.id)

    visit "/departments"

    within "#department-#{department_1.id}" do
      expect(page).to have_content("Alex")
      expect(page).to have_content("Kate")
      expect(page).to have_content("Kiara")
      
      expect(page).to_not have_content("Jeff")
      expect(page).to_not have_content("Jim")
      expect(page).to_not have_content("Jeb")
    end

    within "#department-#{department_2.id}" do
      expect(page).to have_content("Jeff")
      expect(page).to have_content("Jim")
      expect(page).to have_content("Jeb")

      expect(page).to_not have_content("Alex")
      expect(page).to_not have_content("Kate")
      expect(page).to_not have_content("Kiara")
    end

  end

end

# Story 1
# Department Index

# As a user,
# When I visit the Department index page,
# I see each department's name and floor
# And underneath each department, I can see the names of all of its employees