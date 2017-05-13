const webpack = require('webpack');
const glob = require('glob');
const path = require('path');

const CompressionPlugin = require("compression-webpack-plugin");

const production = Object.assign({}, require('./base.config.js'), {
  output: {
    filename: 'public/javascripts/built.js'
  },
  devtool: false
});

production.plugins = production.plugins.concat([
  new webpack.DefinePlugin({
    'process.env': {
      NODE_ENV: '"production"',
    }
  }),
  new webpack.optimize.UglifyJsPlugin({
    compress: {
      warnings: false
    }
  }),
  new CompressionPlugin({
    asset: "[path].gz[query]",
    algorithm: "gzip",
    test: /\.js$/,
    threshold: 0,
    minRatio: 0.8
  }),
  // アプリケーション部とフレームワーク部を分ける場合に
  // new webpack.optimize.CommonsChunkPlugin({
  //   name: 'vendor',
  // })
]);

module.exports = production;
