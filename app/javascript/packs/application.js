/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


import Vue from 'vue/dist/vue.esm'
import TurbolinksAdapter from 'vue-turbolinks'
import VueResource from 'vue-resource'
import axios from "axios"
import ActionCableVue from 'actioncable-vue'
import Router from 'vue-router'
import router from './routes.js'
import _ from 'lodash'

Vue.use(require('vue-resource'));

Vue.use(ActionCableVue, {
	debug: true,
	debugLevel: 'error',
	connectionUrl: 'http://localhost:3000/cable'
});

let axiosToDo = axios.create({
  timeout: 1000,
  headers: {'Authorization': 'qgtSJLxhuATz4gjJVL9Nog'}
});

var webstore = new Vue({
  el: '#app',
  data: { 
    lists: [],
    initialList: {title: "", items: 0, itemsArray: []},
  },
  created: function() {
    axiosToDo.get('/api/lists.json').then(resp => {
      resp.data.lists.forEach((elem) => {
        this.lists.push(elem);
      });
    });
  },
  filters: {
    formatPrice: function(price) {
      return "$" + price.toFixed(2); 
    }
  },
  methods: {
    removeItem: function(index) {
      this.initialList.itemsArray.splice(index,1);
      this.initialList.items -= 1;
    },
    addToCart: function() {
      this.cart.push(this.product.id); 
    },
    addItem: function() {
      this.initialList.items += 1;
      this.initialList.itemsArray.push({ title: "", content: "", due_date: "" });
    },
    submitList: function() {
      axiosToDo.post("/api/lists.json", { list: {title: this.initialList.title,
                                      items_attributes: this.initialList.itemsArray} }).then(
      function(response) {
        console.log(response); 
        this.initialList.title = "";

      }).catch(function(error) {
        console.log(error); 
      });
    },
    
  },
  computed: {
    canSubmit: function() {
      return this.initialList.title.length > 0;
    },
  },
  channels: {
    ListChannel: {
      received(data) {
        if (data.action == "DELETE") {
          let idx = _.findIndex(this.lists, function(o) {
            return o.id == data.id;}); 
          
          this.lists.splice(idx,1); 
        }
        else if(data.action == "ERROR") {
          alert(data.errors); 
          
        }
        else {
          console.log(data.list); 
          this.lists.push(data.list);
        }
      }
    }
  },
  mounted() {
    this.$cable.subscribe({channel: 'ListChannel'});
  }
});
