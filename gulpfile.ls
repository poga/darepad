require! gulp
gutil = require \gulp-util
gls = require \gulp-livescript
gbify = require \gulp-browserify
concat = require \gulp-concat

paths =
  src: <[src/*.ls]>
  app: <[app/*.ls]>

gulp.task \compile-app ->
  gulp.src paths.app
    .pipe gls(bare: true).on \error gutil.log
    .pipe gulp.dest './app/'

gulp.task \build-app <[compile-app]> ->
  gulp.src './app/app.js'
    .pipe gbify!
    .pipe concat 'moltenpad.js'
    .pipe gulp.dest './app/'

gulp.task \compile-src ->
  gulp.src paths.src
    .pipe gls(bare: true).on \error gutil.log
    .pipe gulp.dest './lib/'

gulp.task \dev ->
  gulp.watch paths.src, <[compile-src]>
  gulp.watch paths.app, <[build-app]>

gulp.task \prepublish <[compile-src build-app]>
