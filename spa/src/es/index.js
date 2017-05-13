import createApp from './app';
import { generateRequestMethod } from './services/api/browser';
import API from './services/api';

const api = new API({
  request: generateRequestMethod({
    base: 'http://localhost:5005',
  }),
});

createApp({ api }).$mount('#app');
