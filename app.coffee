axis         = require 'axis'
rupture      = require 'rupture'
autoprefixer = require 'autoprefixer-stylus'
js_pipeline  = require 'js-pipeline'
css_pipeline = require 'css-pipeline'
jeet         = require 'jeet'
# sg           = require('sendgrid')('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')
# jquery       = require 'jquery'
# slick        = require 'slick-carousel'

# gmaps        = require 'gmaps'
# accord       = require 'accord'
# postcss      = accord.load 'postcss'
# poststylus   = require 'poststylus'
# lost         = require 'lost'
# sharps       = require 'sharps'
# jquery       = require 'jquery'
# slick        = require 'slick-carousel'

module.exports =
  ignores: ['readme.md', '**/layout.*', '**/_*', '.gitignore', 'ship.*conf', '.DS_Store', 'sendgrid.env', '.htaccess']

  extensions: [
    js_pipeline(files: 'assets/js/*.coffee')
    # js_pipeline(files: "assets/js/**", out: 'js/build.js', minify: false)
    css_pipeline(files: 'assets/css/*.styl')
  ]

  stylus:
    use: [axis(), rupture(), jeet(), autoprefixer()]
    # use: [axis(), poststylus([ 'lost' ]), autoprefixer()]
    sourcemap: true

  # postcss:
  #   use: [lost()]
  #   map: true

  'coffee-script':
    sourcemap: true

  jade:
    pretty: true

  locals:
    jquery: '//cdnjs.cloudflare.com/ajax/libs/jquery/3.1.0/jquery.min.js'
    # jquery: '/js/vendor/jquery.min.js'
    # jquery: '//cdnjs.cloudflare.com/ajax/libs/jquery/1.12.4/jquery.min.js'
    # jquery_map: '//cdnjs.cloudflare.com/ajax/libs/jquery/3.1.0/jquery.min.map'
    waypoints_js: '//cdnjs.cloudflare.com/ajax/libs/waypoints/4.0.0/jquery.waypoints.min.js'
    # waypoints_sticky_js: '//cdnjs.cloudflare.com/ajax/libs/waypoints/4.0.0/shortcuts/sticky.min.js'
    slick_js: '//cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.6.0/slick.min.js'
    # slick_js: '/js/vendor/slick.min.js'
    slick_css: '//cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.6.0/slick.min.css'
    # slick_css: '/js/vendor/slick.css'
    slick_theme: '//cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.6.0/slick-theme.min.css'
    # slick_theme: '/js/vendor/slick-theme.css'
    # gmapAPIcb: '//maps.googleapis.com/maps/api/js?key=AIzaSyCSXRuwBVbzoOJoqIf8p3F7QF1BVvEPcPc&callback=initMap'
    gmapAPI: '//maps.googleapis.com/maps/api/js?key=AIzaSyCSXRuwBVbzoOJoqIf8p3F7QF1BVvEPcPc'
    # gmaps: '//cdnjs.cloudflare.com/ajax/libs/gmaps.js/0.4.24/gmaps.min.js'
    # featherlight: '//cdnjs.cloudflare.com/ajax/libs/featherlight/1.5.0/featherlight.gallery.min.js'
    # featherlight_css: '//cdnjs.cloudflare.com/ajax/libs/featherlight/1.5.0/featherlight.min.css'
    validate_js: '//cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.15.1/jquery.validate.min.js'
