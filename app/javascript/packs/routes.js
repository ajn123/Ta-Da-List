import Vue from 'vue'
import VueRouter from 'vue-router';

import store from './vuex'
Vue.use(VueRouter);


import HomeIndex from './components/Home.vue';
import LogIn     from './components/LogIn.vue.erb'
import SignUp    from './components/SignUp.vue.erb'


const router = new VueRouter({
  mode: 'history',
  routes: [
    { path: '/', component: HomeIndex, name: 'root_path' },
    { path: '/login', component: LogIn, name: 'login_path'},
    { path: '/signup', component: SignUp, name: 'signup_path'}
  ]
});

router.beforeEach((to, from, next) => {
  console.log("beforeEach");
  next();

});

export default router;
