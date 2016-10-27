axis         = require 'axis'
rupture      = require 'rupture'
autoprefixer = require 'autoprefixer-stylus'
js_pipeline  = require 'js-pipeline'
css_pipeline = require 'css-pipeline'
jeet         = require 'jeet'
sg           = require 'sendgrid'

module.exports =
  ignores: ['readme.md', '**/layout.*', '**/_*', '.gitignore', 'ship.*conf', '.DS_Store', 'sendgrid.env', '.htaccess']

  extensions: [
    js_pipeline(files: 'assets/js/*.coffee', minify: true, out: 'js/build.min.js', hash: true),
    css_pipeline(files: 'assets/css/*.styl', minify: true, out: 'css/build.min.css', hash: true)
  ]

  stylus:
    use: [axis(), rupture(), jeet(), autoprefixer()]

  locals:
    jquery: '//cdnjs.cloudflare.com/ajax/libs/jquery/3.1.0/jquery.min.js'
    waypoints_js: '//cdnjs.cloudflare.com/ajax/libs/waypoints/4.0.0/jquery.waypoints.min.js'
    # waypoints_sticky_js: '//cdnjs.cloudflare.com/ajax/libs/waypoints/4.0.0/shortcuts/sticky.min.js'
    slick_js: '//cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.6.0/slick.min.js'
    slick_css: '//cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.6.0/slick.min.css'
    slick_theme: '//cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.6.0/slick-theme.min.css'
    gmapAPI: '//maps.googleapis.com/maps/api/js?key=AIzaSyCSXRuwBVbzoOJoqIf8p3F7QF1BVvEPcPc'
    validate_js: '//cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.15.1/jquery.validate.min.js'
