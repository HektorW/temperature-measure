const { join } = require('path')
const OfflinePlugin = require('offline-plugin')

const DEVELOPMENT = process.env.NODE_ENV === 'development'
const PRODUCTION = process.env.NODE_ENV === 'production'

const config = {
  entry: join(__dirname, 'src/index.js'),

  output: {
    path: join(__dirname, 'dist/'),
    filename: 'index.js',
  },

  resolve: {
    modulesDirectories: ['node_modules'],
    extensions: ['', '.js', '.elm'],
  },

  module: {
    noParse: [/.elm$/],
    loaders: [{
      test: /\.html$/,
      exclude: /node_modules/,
      loader: 'file?name=[name].[ext]',
    }, {
      test: /\.css$/,
      exclude: /node_modules/,
      loader: 'style!css',
    }, {
      test: /\.elm$/,
      exclude: [/elm-stuff/, /node_modules/],
      loader: 'elm-webpack?pathToMake=node_modules/.bin/elm-make',
    }],
  },

  plugins: [],
}

if (DEVELOPMENT) {
  config.devServer = {
    inline: true,
    proxy: {
      '/api': {
        target: 'http://localhost:1080',
        secure: false,
      },
    },
  }
}

if (PRODUCTION) {
  config.plugins.push(new OfflinePlugin())
}

module.exports = config
