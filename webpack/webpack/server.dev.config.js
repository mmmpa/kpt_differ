const webpack = require('webpack');

// サーバーサイドのコンパイル
// 要調整

const development = Object.assign({}, require('./base.config.js'), {
  target: 'node',
  entry: './src/server-index.js',
  output: {
    filename: "server/built.js"
  },
});

development.plugins = development.plugins.concat([
  new webpack.DefinePlugin({
    'process.env': {
      NODE_ENV: JSON.stringify(process.env.NODE_ENV || 'development'),
    }
  })
]);

module.exports = development;


