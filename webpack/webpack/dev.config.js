const webpack = require('webpack');

const development = Object.assign({}, require('./base.config.js'), {
  devtool: '#eval-source-map'
});

development.plugins = development.plugins.concat([
  new webpack.DefinePlugin({
    'process.env': {
      NODE_ENV: JSON.stringify(process.env.NODE_ENV || 'development'),
    }
  })
]);

module.exports = development;
