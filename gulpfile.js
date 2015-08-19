'use strict';

var path = require('path'),
    del = require('del'),
    gulp = require('gulp'),
    gutil = require("gulp-util"),
    watch = require('gulp-watch'),
    stylus = require('gulp-stylus'),
    changed = require('gulp-changed'),
    notify = require("gulp-notify"),
    nib = require('nib'),
    imagemin = require('gulp-imagemin'),
    rev = require('gulp-rev'),
    inject = require('gulp-inject'),
    through2 = require('through2'),
    runSequence = require('run-sequence'),
    express = require('express'),
    webpack = require('webpack'),
    webpackConfig = require("./webpack.config.js"),
    webpackProductionConfig = require('./webpack-production.config.js');

var dest = './public/build';

var config = {
  js: {
    src: "./app/main.cjsx",
    dest: dest
  },
  stylus: {
    files: './css/**/*',
    src: "./css/main.styl",
    out: 'main.css',
    dest: dest
  },
  html: {
    src: "./public/index.html",
    dest: dest
  },
  clean: {
    src: dest + '/**/*',
    dest: dest + '/'
  },
  images: {
    src: './public/assets/**/*',
    dest: dest + '/assets'
  },
  server: {
    port: 3434
  }
}

// error handing function, pass to on 'error'
var handleErrors = function() {
  var args = Array.prototype.slice.call(arguments);

  notify.onError({
    title: "Compile Error",
    message: "<%= error.message %>"
  }).apply(this, args);

  this.emit('end'); // Keep gulp from hanging on this task
};

var execWebpack = function(config){
  webpack((config), function(err, stats) {
    if (err) new gutil.PluginError("execWebpack", err);
    gutil.log(stats.toString({colors: true}));
  });
}

var createServer = function(port) {
  var app = express()
  app.use(express.static(path.resolve(dest)))
  app.listen(port, function(){
    gutil.log("Server started on ", port);
  })
}

// remove the build files
gulp.task('clean', function () {
    del([dest])
});

// copy / minify images
gulp.task('images', function() {
  return gulp.src(config.images.src)
    .pipe(changed(config.images.dest))
    .pipe(imagemin())
    .pipe(gulp.dest(config.images.dest));
});

// copy html to build dir
gulp.task('html', function() {
  var target = gulp.src(config.html.src);
  var sources = gulp.src([dest + '/*.css'], {read: false});
  return target.pipe(inject(sources, {ignorePath: 'public/build', addPrefix: '.', addRootSlash: false}))
    .on('error', handleErrors)
    .pipe(gulp.dest(config.html.dest));
});

// compile stylus and move to build dir
gulp.task('stylus', function() {
  return gulp.src(config.stylus.src)
    .pipe(stylus({use: nib(), 'include css': true, errors: true}))
    .on('error', handleErrors)
    .pipe(gulp.dest(config.stylus.dest));
});

// compile stylus for production build and move to build dir
gulp.task('stylus:build', function() {
  return gulp.src(config.stylus.src)
    .pipe(stylus({use: nib(), 'include css': true, errors: true}))
    .on('error', handleErrors)
    .pipe(rev())
    .pipe(gulp.dest(config.stylus.dest));
});

// start webpack
gulp.task('webpack', function(callback){
  execWebpack(webpackConfig);
  callback();
})

// compile js for production build and move to build dir
gulp.task("webpack:build", function(callback) {
  // modify some webpack config options
  var myConfig = Object.create(webpackProductionConfig);
  myConfig.plugins = myConfig.plugins.concat(
    new webpack.DefinePlugin({
      "process.env": {
        // This has effect on the react lib size
        "NODE_ENV": JSON.stringify("production")
      }
    }),
    new webpack.optimize.UglifyJsPlugin()
  );

  // run webpack
  webpack(myConfig, function(err, stats) {
    if(err) throw new gutil.PluginError("webpack:build", err);
    gutil.log("[webpack:build]", stats.toString({
        colors: true
      })
    );

    // write the hashed main.js to /public/build/index.html
    var jsFilename = stats.toJson().assetsByChunkName['main'];

    return gulp.src('./public/build/index.html')
      .on('error', handleErrors)
      .pipe(through2.obj(function (file, enc, tCb) {
        file.contents = new Buffer(String(file.contents)
          .replace('main.js', jsFilename));
        this.push(file);
        tCb();
      }))
      .pipe(gulp.dest(config.html.dest));
    callback();
  });
});

gulp.task('watch', function(callback) {
    runSequence(
    ['stylus', 'images'],
    'html',
    'webpack',
    callback
  );
  gulp.watch(config.stylus.files, ['stylus']);
  gulp.watch(config.html.src, ['html']);
  gulp.watch(config.images.src, ['images']);
});

// start a dev server
gulp.task('serve', function(){
  createServer(config.server.port);
});

gulp.task('build', function(callback){
  runSequence(
    ['stylus:build', 'images'],
    'html',
    'webpack:build',
    callback
  );
});

gulp.task('default', ['serve', 'watch']);