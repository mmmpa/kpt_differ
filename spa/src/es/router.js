import VueRouter from 'vue-router';
import {
  RootContext,
  Diff,
} from './all-components';

export default new VueRouter({
  mode: 'history',
  routes: [
    {
      path: '/',
      component: RootContext,
      children: [
        {
          path: '', component:  Diff,
        },
      ],
    },
  ],
});
