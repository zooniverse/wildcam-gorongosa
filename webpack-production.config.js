var path = require('path');
var webpack = require('webpack');
var config = require('./webpack.config');

module.exports = Object.assign(config, {
  watch: false,
  watchDelay: 0,
  output: {
    path: path.join(__dirname, '/public/build'),
    publicPath: '',
    filename: '[name].[hash].js',
    chunkFilename: '[id].[hash].bundle.js'
  },
  resolve: {
    extensions: ['', '.js', 'jsx', '.cjsx', '.coffee']
  },
  plugins: [
    function() {
      this.plugin('done', function(stats) {
        require('fs').writeFileSync(
          path.join(__dirname, 'public/build', 'stats.json'),
          JSON.stringify(stats.toJson())
        );
      });
    }
  ]
});
