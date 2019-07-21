# Ta-Da List


This is a Single Page Application that allows users to 
log in and create a to-do list.  The user can also interact
with their list through their api.



| URL                                                                             | Result                            |
| ======                                                                          | =========                         |
| GET /lists.json                                                                 | Returns all the users lists       |
| POST /list.json PARAMS: title, players_attributes: [{title, content, due_date}] | Creates a list with as many items |




Rails backend api with Vue.js binding the frontend

## Run
* Clone Project
* cd into the directory
* run bundle install
* run rails s 
