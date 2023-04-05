# TODO

This project is a task management application built with Ruby 2.7.2 and Rails 6.1.7. It uses BDD methodology and is tested with RSpec and Capybara. The views are built using the Slim template engine. User authentication and authorization are implemented using the Devise gem. 

### Features

The application allows authenticated users to:

* Create, read, update, and delete tasks
* Set deadlines for tasks and see the remaining time until the deadline or how long the task is overdue
* Mark tasks as done or not done

### Installation

1. Clone the repository
2. Run `bundle install` to install the required gems
3. Run `rails db:migrate` to run the database migrations
4. Run `rails server` to start the application
5. Open your web browser and navigate to `http://localhost:3000`

### Tests

The application includes RSpec tests, which can be run using the command `rspec spec` from the terminal.