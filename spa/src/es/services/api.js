import { Method } from './api/constants';

export default class API {
  constructor ({ request, storePromise = false }) {
    this._req = request;
    this.promises = [];
    this.storePromise = storePromise;
  }

  req (p) {
    const promise = this._req(p);

    // SSR の時のみ保持する (リクエストごとに廃棄される)
    if (this.storePromise) {
      this.promises.push(promise);
    }

    return promise;
  }

  createMarkdown ({ params = {}, body = {}, query = {} } = {}) {
    return this.req({
      params,
      body,
      query,
      method: Method.Post,
      uri: '/api/markdowns',
    });
  }

  createDiff ({ params = {}, body = {}, query = {} } = {}) {
    return this.req({
      params,
      body,
      query,
      method: Method.Post,
      uri: '/api/markdowns/diff',
    });
  }
}