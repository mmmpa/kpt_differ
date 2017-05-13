import Vue from 'vue';
import VueRouter from 'vue-router';
import router from './router';
import common from './mixins/common';

Vue.use(VueRouter);
Vue.mixin(common);

require('./all-components');

export default function createApp ({ api }) {
  return new Vue({
    template: '<router-view></router-view>',
    router,
    beforeCreate () {
      this.$root.api = api;
    },
  });
}
