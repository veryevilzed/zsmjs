var webpack = require('webpack');
var path = require('path');
var bower_dir = path.join(__dirname, 'bower_components');
var node_modules_dir = path.join(__dirname, 'node_modules');


var config = {
  context: __dirname,
  entry: './src/main.coffee',

  output: {
    filename: 'zsm.min.js',
    path: __dirname + '/build',
  },
  resolve: {
      root: [path.join(__dirname, "bower_components")],
      alias: {}
  },
  plugins: [
      new webpack.optimize.UglifyJsPlugin({minimize: true})
  ],
  module: {
    loaders: [
      //{ test: /\.js$/,     loader: 'babel-loader', exclude: /node_modules/ },
      //{ test: /\.scss$/,   loader: 'style-loader!css-loader!sass-loader' },
      { test: /\.coffee$/, loader: "coffee-loader" },
      { test: /\.(coffee\.md|litcoffee)$/, loader: "coffee-loader?literate" }
    ]
  }
};

//config.addVendor('mod1', path.resolve(bower_dir, 'mod1/main.js'));

module.exports = config;
