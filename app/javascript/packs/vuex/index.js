import Vue from 'vue/dist/vue.esm'
import Vuex from 'vuex';
Vue.use(Vuex);


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
    
  },

});


export default store;
