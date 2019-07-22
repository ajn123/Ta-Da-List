import Vue from 'vue/dist/vue.esm';
import VueRouter from 'vue-router';
import HomeIndex from './components/Home.vue';
Vue.use(VueRouter);


const router = new VueRouter({
  mode: 'history',
  routes: [
    { path: '/', component: HomeIndex, name: 'root_path' },
  ]
});

export default router;
