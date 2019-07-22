<template> 

  <div id="app">
    <h1>
      Lists:
    </h1>
    <ol class="list-group">
      <li class="list-group-item" v-for="(list, index) in lists">
        <h1>
          {{ list.title }} 
        </h1>
        <br />
        <h3>
          Items: {{ list.items.length }}
        </h3>
          <div style="margin:10px" class="card" v-for="(item,index) in list.items">
            <div class="card-body">
              
              <h5 class="card-title"> 
                {{item.title}} 
              </h5>
              <p class="card-text">
              {{ item.content}}
              </p>
              <h6 class="card-subtitle mb-2">
                Due: {{ item.due_date }}
              </h6>
            </div>
          </div>
      </li>
    </ol>

    <div class="list-form">
      
      <label for="">List Title: </label>
      <input v-model="initialList.title" class="form-control">
      <div v-for="(itemArray, itemCount) in initialList.itemsArray" class="form-group">
        <label > Item {{itemCount + 1}} Title: </label>
        <input v-model="itemArray.title" class="form-control">
        <label > Item {{itemCount + 1}} Content: </label>
        <input v-model="itemArray.content" class="form-control">

        <label for="">Due Date: </label>
        <input type="date" class="form-control" value="<%= Date.today.to_s %>" v-model="itemArray.due_date"/>
        <button class="btn btn-danger" @click="removeItem(itemCount)">REMOVE Item {{itemCount + 1}}</button>
      </div>

      <button class="btn btn-secondary" @click="addItem">Add Item</button>

      <button v-show="canSubmit" class="btn-lg btn-block btn-primary" @click="submitList">Submit List</button>
    </div>
  </div>

</template>



<script>
import axios from "axios"

let axiosToDo = axios.create({
  timeout: 1000,
  headers: {'Authorization': 'qgtSJLxhuATz4gjJVL9Nog'}
});
  
    export default {
data: function() {
      return { 
      lists: [],
      initialList: {title: "", items: 0, itemsArray: []}};
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

  
  }


</script>
