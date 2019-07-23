import Vue from 'vue/dist/vue.esm'
import Vuex from 'vuex';
Vue.use(Vuex);

import axios from "axios"

let axiosToDo = axios.create({
  timeout: 1000,
  headers: {'Authorization': 'qgtSJLxhuATz4gjJVL9Nog'}
});

const store = new Vuex.Store({
 state: {
    lists: [],
    initialList: {title: "", items: 0, itemsArray: []},
    user: { token: null }
  }
  ,
  mutations: {
    
  },
  actions: {
    logIn(context, email, password) {
      axiosToDo.post('/sessions.json', {
        session: { email: "", password: ""}

      }).then((resp) => {
        
      }).catch((error) => {
        console.log(error);
      });
      
    }
    
  },

});


export default store;
