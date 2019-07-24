<template>
  <div class="container">
    <nav-bar></nav-bar>
  
    <router-view></router-view>
    <footer>
      
    </footer>

  </div>
</template>

<script>
 
import NavBar from './components/NavBar.vue.erb'

export default {
  name: 'App',
  components: {
    NavBar
  },
  data() {
    return {
      layout: 'div',
    };
  },
};
</script>
