# README

This is a Project management service with the following features:
- Overview of all projects
- Creating new projects
- Updating projects

Things you may want to cover:

* Ruby version

3.2.1

* System dependencies

PostgreSQL, Docker, Ruby 3.2.1

* Configuration
```
cp .env.example .env
bundle install
```
* Database creation
```
rails db:create
```
* Database initialization
```
rails db:migrate && rails db:seed
```
* How to run the test suite
```
rspec spec/
```
* Services (job queues, cache servers, search engines, etc.)

Fetch All Projects
```
curl --location --request GET 'http://localhost:3000/projects/' \
--header 'Content-Type: application/json' \
--data '{
    "project": {
        "name": "Test 2",
        "state": "failed",
        "owner_id": "6a45b325-418b-4de3-aae0-248fc1ffb624"
    }
}'
```

Create Project
```
curl --location 'http://localhost:3000/projects' \
--header 'Content-Type: application/json' \
--data '{
    "project": {
        "name": "Test 1",
        "state": "failed",
        "owner_id": "6a45b325-418b-4de3-aae0-248fc1ffb624"
    }
}'
```

Update Project
```
curl --location --request PUT 'http://localhost:3000/projects/1aa5ae84-5565-4371-b4a4-f5891e6ff4b1' \
--header 'Content-Type: application/json' \
--data '{
    "project": {
        "name": "Test 2",
        "state": "failed",
        "owner_id": "6a45b325-418b-4de3-aae0-248fc1ffb624"
    }
}'
```

* Deployment instructions
```
dockr-compose up
```
* Pending Tasks

Due to time constraints couldn't complete the following:
- Add participants endpoints. 
- Cover all the test scenarios. 
- Multi stage docker build for caching.
- Caching on the employee API fetch

* Areas of Improvements

The employees details are fetched from an external API. This can be integrated in multiple ways:
1. We can store the employee details in database and update it everyday using a cron job. This approach will be useful if there are huge employee data and fetching this and parsing for every request won't be feasible.
2. Another approach is to implement caching, where we will fetch the data from cache if it exist otherwise will contact the external API. This can be done only if the employee data is not huge.
3. We can use employees/:id API to fetch whenever required. But the number of requests will be more for assign participants API where we need to check the department.
