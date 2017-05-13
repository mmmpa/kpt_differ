const webpack = require('webpack');

const jsConfiguration = {
  entry: ['babel-polyfill', './src/es/index.js'],
  output: {
    publicPath: 'javascripts',
    filename: 'spa.js'
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

const ExtractTextPlugin = require('extract-text-webpack-plugin')
const cssConfiguration = {
  entry: './src/sass/common.sass',
  output: {
    publicPath: 'stylesheets',
    filename: "common.css"
  },
  module: {
    loaders: [
      {
        test: /\.sass|\.scss/,
        loader: ExtractTextPlugin.extract({
          fallbackLoader: "style-loader",
          loader: "css-loader?minimize!sass-loader",
          publicPath: 'stylesheets',
        })
      }
    ]
  },
  plugins: [
    new ExtractTextPlugin("common.css")
  ]
};

module.exports = jsConfiguration;
