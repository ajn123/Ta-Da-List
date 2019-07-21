# Ta-Da List


This is a Single Page Application that allows users to 
log in and create a to-do list.  The user can also interact
with their list through their api.





|  URL               | Parameters
| ========           | ===========                                             |
| POST   /lists.json | content, items_attributes: {[title, content, due_date]} |
| GET    /lists.json |                                                         |




This project uses:
* accepts_nested_attributes_for to allow lists to submit items in their request
* protect_from_forgery with: nullsession to allow api requests form any where
* Action Cable to let the frontend app update after any API requests
* Dynamic form validation with Vue.js
* 


Rails backend api with Vue.js binding the frontend

## Run
* Clone Project
* cd into the directory
* run bundle install
* run rails s 




# Thanks
* https://vuejs.org/ 
* https://www.learnenough.com/action-cable-tutorial
