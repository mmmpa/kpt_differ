export default class Base {
  constructor () {
    if (!Base.id || Base.id >= 9007199254740992) {
      Base.id = 1;
    }

    this._oid = (Base.id += 1);
  }

  get attributes () {
    return this._attributes;
  }

  insert (params = {}, configurations = {}) {
    this._attributes = Object.keys(configurations);
    this._configurations = configurations;
    this.constraints = {};

    this.attributes.forEach(k => this[k] = params[k]);
  }
}
