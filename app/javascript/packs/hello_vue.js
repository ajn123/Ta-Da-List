import Vue from 'vue/dist/vue.esm'
import TurbolinksAdapter from 'vue-turbolinks'
import VueResource from 'vue-resource'
import axios from "axios";

Vue.use(require('vue-resource'));

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
      fetch('/api/lists.json').then((r) => {
        console.log(r); 
      });
        axios.get('/api/lists.json').then(resp => {
          console.log(resp); 
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
    }
    
  });


  var calc = new Vue( {
    el: '#calc',
    data: { length: 0, width: 1},
    computed: {
      area: function() {
        return this.length * this.width; 
      }
    }
  });

}); 




