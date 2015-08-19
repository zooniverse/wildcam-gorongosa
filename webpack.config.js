module.exports = {
  watch: true,
  context: __dirname + '/app',
  entry: {
    main: './main.cjsx'
  },
  output: {
    path: __dirname + '/public/build',
    filename: '[name].js',
    chunkFilename: '[id].bundle.js'
  },
  resolve: {
    extensions: ['', '.js', '.jsx', '.cjsx', '.coffee']
  },
  module: {
    loaders: [
      { test: /\.cjsx$/, loaders: ['coffee-loader', 'cjsx-loader'] },
      { test: /\.jsx$/, loader: 'jsx-loader'},
      { test: /\.coffee$/, loader: 'coffee-loader' },
      { test: /\.json$/, loader: 'json-loader' },
      { test: /\.js?$/, loader: 'babel' }
    ],
    noParse: [
      /^react$/
    ]
  },
  node: {
    fs: 'empty'
  },
  devtool: 'eval-source-map'
};
