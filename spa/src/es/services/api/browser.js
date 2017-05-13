import { Method } from './constants';
import APIError from './api-error';

const axios = require('axios');
const queryString = require('querystring');

export function generateRequestMethod ({ base }) {
  return ({ uri, method, params, instantiate, body }) => {
    return request({ uri: `${base}${uri}`, method, params, body, instantiate });
  };
}

export function request ({ uri, method, params = {}, body = {}, query = {}, instantiate = p => p }) {
  return prepare({ uri, method, params, body, query })
    .then(response => Promise.resolve(instantiate(response.data)))
    .catch(error => Promise.resolve(new APIError(error)));
}

export function prepare ({ uri, method, params, body, query }) {
  switch (method) {
    case Method.Get:
      return axios.get(normalize({ uri, params, query }));
    case Method.Post:
      return axios.post(normalize({ uri, params }), body);
    case Method.Patch:
      return axios.patch(normalize({ uri, params }), body);
    case Method.Put:
      return axios.put(normalize({ uri, params }), body);
    case Method.Delete:
      return axios.delete(normalize({ uri, params }), body);
    default:
      return axios;
  }
}

const placeHolder = /(\{:([^}]+)\})/;

export function normalize ({ uri, params, query }) {
  return addQueryString({
    uri: insertParams({ uri, params }),
    query,
  });
}

export function insertParams ({ uri, params }) {
  if (!params) {
    return uri;
  }

  let matched = null;
  while ((matched = uri.match(placeHolder))) {
    uri = uri.replace(placeHolder, encodeURIComponent(params[matched[2]] || ''));
  }

  return uri;
}

export function addQueryString ({ uri, query }) {
  if (!query) {
    return uri;
  }

  const params = Object.keys(query).reduce((a, k) => (a[k] = query[k], a), {});
  return `${uri}?${queryString.stringify(params)}`;
}
