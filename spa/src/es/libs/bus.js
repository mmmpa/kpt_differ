export const component = {
  props: ['bucket'],
  destroyed () {
    this.isDestroyed = true;
  },
  data () {
    return {
      locked: false,
      lockCount: 0,
    };
  },
  methods: {
    dispatch (name, ...args) {
      return this.$root.hub.emit(name, this, ...args);
    },
    lock () {
      this.lockCount += 1;
      this._checkLock();
    },
    unlock ({ force } = {}) {
      this.lockCount = (force || this.lockCount === 0)
        ? 0
        : this.lockCount - 1;

      this._checkLock();
    },
    _checkLock () {
      this.locked = this.lockCount > 0;
    },
  },
};

export const transition = {
  created () {
    setTimeout(() => this.transit(this.$route), 0);
  },
  watch: {
    '$route': function (v) {
      this.transit && this.transit(v);
    },
  },
  methods: {
    transit ({ name, params, query }) {
      switch (true) {
        case name && name.indexOf('Index') !== -1:
          return this.transitIndex && this.transitIndex(name, query);
        default:
          return this.transitDetail && this.transitDetail(params);
      }
    },
    transitIndex (name, query) {
      if (!query.page) {
        this.$router.replace({ name, query: this.indexDefaultQuery });
        return;
      }

      this.dispatch(this.indexDispatcher, query);
    },
  },
};

export const useAPI = {
  beforeCreate () {
    this.api = this.$root.api;
  },
};

export const context = {
  template: '<router-view :bucket="bucket"></router-view>',
  mixins: [component, transition, useAPI],
  created () {
    this.listenrsStore = [];
    this.receive(this._addComponentEvent);
  },
  destroyed () {
    this._removeAllComponentEvent();
  },
  methods: {
    _addComponentEvent (name, callback) {
      this.listenrsStore.push({ name, callback });
      this.$root.hub.on(name, callback);
    },
    _removeAllComponentEvent () {
      this.listenrsStore.forEach(({ name, callback }) => this.$root.hub.off(name, callback));
      this.listenrsStore = null;
    },
    receive () {
    },
  },
};

export function dispatch (vm, name, ...args) {
  return vm.$root.hub.emit(name, ...args);
}
