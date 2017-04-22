const webpack = require('webpack');

module.exports = {
  entry: ['babel-polyfill', './src/browser-index.js'],
  output: {
    publicPath: 'javascripts',
    filename: 'built.js'
  },
  module: {
    rules: [
      {
        test: /\.vue$/,
        loader: 'vue-loader',
        options: {
          loaders: {
            js: 'babel-loader!eslint-loader',
          },
          template: {
            pretty: true
          }
        }
      },
      {
        test: /\.js$/,
        use: [
          'babel-loader',
          'eslint-loader',
        ],
        exclude: /node_modules/
      },
    ]
  },
  plugins: [
    new webpack.ProvidePlugin({
      'Promise': 'es6-promise'
    }),
    new webpack.DefinePlugin({
      '__DIR__': JSON.stringify(process.env.NODE_ENV),
    }),
  ],
  resolve: {
    alias: {
      'vue$': 'vue/dist/vue.esm.js'
    }
  },
  devServer: {
    historyApiFallback: true,
    noInfo: true
  },
  performance: {
    hints: false
  },
};
