import Vue from 'vue'
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
    user: { token: null, api_key: null }
  },
  mutations: {
    userLogIn(state, user) {
      state.user.token = user.id;
      state.user.api_key = user.api_key;
    },
    userLogOut(state) {
      state.user.token = null;
      state.user.api_key = null;
    }
    
  },
  actions: {
    },
    
  

});


export default store;
