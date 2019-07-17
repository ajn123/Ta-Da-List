import Vue from 'vue/dist/vue.esm'
import TurbolinksAdapter from 'vue-turbolinks'
import VueResource from 'vue-resource'
import axios from "axios"
import ActionCableVue from 'actioncable-vue'

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

document.addEventListener('DOMContentLoaded', () => {

  var webstore = new Vue({
    el: '#app',
    data: { sitename: 'Vue.js Pet Depot',
    product:{id: 1, name: "IPhone", price: 999.99, description: "A device to ruin your life"},
      items: [
        { message: "hello"},
        { message: "World 2"}
      ],
      cart: [],
      lists: [],
    },
    created: function() {
      axios.get('/api/lists.json').then(resp => {
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
      addToCart: function() {
        this.cart.push(this.product.id); 
      },
      showCart: function() {
      }
      
    },
    computed: {
      fullName: function() {
        return ["Alex", "Norton"].join(' ');  
      }
    },
    channels: {
      ListChannel: {
        received(data) {
          if (data.action == "DELETE") {
            let idx = _.findIndex(this.lists, function(o) {
              return o.id == data.id;}); 
            
            this.lists.splice(idx,1); 
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




