const { join } = require('path')

module.exports = {
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
    },{
      test: /\.elm$/,
      exclude: [/elm-stuff/, /node_modules/],
      loader: 'elm-webpack?pathToMake=node_modules/.bin/elm-make',
    }],
  },

  devServer: {
    inline: true,
    proxy: {
      '/api': {
        target: 'http://localhost:1080',
        secure: false,
      },
    },
  },
}
