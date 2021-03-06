import Vue from 'vue/dist/vue.esm'
import TurbolinksAdapter from 'vue-turbolinks'
import VueResource from 'vue-resource'
import axios from "axios"
import ActionCableVue from 'actioncable-vue'
import Router from 'vue-router'

import _ from 'lodash'


Vue.use(require('vue-resource'));

Vue.use(ActionCableVue, {
	debug: true,
	debugLevel: 'error',
	connectionUrl: 'http://localhost:3000/cable'
});

function isNotNumericValue(value) {
  return isNaN(value) || !isFinite(value);
}

let axiosToDo = axios.create({
  timeout: 1000,
  headers: {'Authorization': 'qgtSJLxhuATz4gjJVL9Nog'}
});

document.addEventListener('DOMContentLoaded', () => {
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
}); 




