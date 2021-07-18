# TopSore REST API Version 1.0

This API will be used to keep scores for a certain game for players.  This API only accepts and returns JSON payloads for its operations. The score data of a Player consists of name, score, and time.  At creation an  id is assigned to a score. It is not possible to edit a score once created.

### Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

This API is developed using Ruby 3.0.0 adn Rails 6.1.4 other dependencies are shown below. The Datastore for this API is currently set to sqlite3

### Building the API
  
Download the latest source code from GitHub repository and save it into a local directory. Execute the following command fom the root directory of the source.

>$  _bundle install_

### Database creation and Database initialization

Currently Sqlite3 is configure in the configuration files. Execute following command from the Project directory

> _$ rails db:migrate_
>
> $ rails db:seed

* ### Running the tests

The unit tests and Integration tests are developed using RSpec. Execute below command from the project directory.
  >$ _bundle exec rspec_

* ### Starting the Server and Testing by  Clients
The server( Endpoint ) can be started by executing the below command from the project folder.

> $ rails s

Now the service will be running at http://localhost:3000 port. Use Postman or cURL tool to make following endpoints calls.

##A PI Endpoints

Following API are exposed as RESTful endpoints.

###  1 Create a Score:  POST /api/v1/scores
JSON encode content of the new Score  is to be created.  e.g:

{
"player": "KaTe",
"score": "123",
"time": "2021-06-17"
}

Returns Http Status 201 if succeeded otherwise 400

###  2 Get list of Scores : GET /api/v1/scores?
Following query string are supported for filtering and paging. 

created_after:Date(as YYYY-mm-dd)

created_before:Date(as YYYY-mm-dd)

player[] ( as an Array string as player names) .  e.g player[]='Hikaru',player[]='Newton'

page: Page number as integer for pagination ( Default us 20 items per page)

Returns Http Status 200 if succeeded other wise 4xx
The return JSON content shall also have the paging metadata. The same informaiton is also available as ResponseHeader asw well
### 3 Get a single Score : GET /api/v1/scores/:id
Id of the score to retrieve is encoded as part of the URL

Returns Http Status 200 if succeeded other wise 404

### 4 Delete a Score: DELETE /api/v1/scores/:id
Id of the score to be deleted is encoded as part of the URL

Returns Http Status 200

### 5 Get history of a player :  GET /api/v1/scores/history/:player
Name of the player who's history is required is encoded in the URL.
The client can request a player history. The resulting payload shall contain:

    high score (time and score) which the best ever score of the player.
    low score (time and score) worst score of the player.
    average score value for player
    list of all the scores (time and score) of this player.

Returns Http Status 200 if succeeded other wise 4xx
