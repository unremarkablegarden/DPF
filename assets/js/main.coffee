$ ->

  scrollingNow = false
  mobile = false

  #   disableWaypoints = true
  #   disableValidate = true
  #   disableGoogleMaps = true

  winW = $(window).width()
  if winW < 769
    mobile = true
    console.log('jq mobile = true')

  $('nav a').click ->
    link = $(this).attr('href')
    scrollDownTo($(this), link)
    if( mobile )
      $('li.mobile').trigger('click')
    return false

  $('#gallery button').click ->
    link = $(this).data('link')
    scrollDownTo($(this), link)

  scrollDownTo = (t, link) ->
    scrollingNow = true
    $('nav a').removeClass('active')
    sel = link + " h1"
    aTag = $(sel)
    offset = aTag.offset()
    move = offset.top - 140
    $('html,body').animate { scrollTop: move }, 800, ->
      t.addClass('active')
      scrollingNow = false
    return false

  $('#header .logo img, #backTop').click ->
    scrollingNow = true
    $('html,body').animate { scrollTop: 0 }, 500, ->
      scrollingNow = false
      $('nav a').removeClass('active')

  # if disableWaypoints == false
  $('section').waypoint ->
    if( ! scrollingNow )
      sectionId = this.element.id
      $('nav a').removeClass('active')
      $('.' + sectionId).addClass('active')

  scrolld = 0

  $(window).on 'scroll': ->
    scrolld = $(window).scrollTop()
    scrolldf(scrolld)
    backTop(scrolld)

  startScroll = $('#header ul').height()

  scrolldf = (scrolld) ->
    if( ! mobile )
      newHeight = startScroll - scrolld
      $('#header nav ul').height(newHeight)

      opa = (scrolld) / 50
      opa = 1 - opa
      if opa < 0
        opa = 0
      $('.lang').css('opacity', opa)

      shadeSize = scrolld / 2
      shadeOpa = scrolld / 100
      if(shadeSize > 100)
        shadeSize = 100
      if(shadeOpa > 0.7)
        shadeOpa = 0.7
      shade = '0 0 ' + shadeSize + 'px rgba(0,0,0,' + shadeOpa + ')'
      $('#header').css({ 'box-shadow': shade })

  backTop = (scrolld) ->
    opa = (scrolld - 300) / 300
    if opa > 0.8
      opa = 0.8
    $('#backTop').css('opacity', opa)

  if( mobile )
    linkz = $('li.link')
    linkz.addClass('hideMobile')
    $('li.mobile').click ->
      if( linkz.hasClass('hideMobile') )
        # SHOW
        linkz.removeClass('hideMobile')
        $('nav').addClass('open')
      else
        # HIDE
        linkz.addClass('hideMobile')
        $('nav').removeClass('open')
      return false
    $('li.link').click ->
      linkz.addClass('hideMobile')


  $('button.vita').click ->
    link = $(this).data('vita')
    content = $( link )
    $('#viewer .content').html( content ).parent().show()
    return false

  $('.x span').click ->
    $('#viewer').hide()

  $('#footer a').click ->
    t = $(this)
    if t.hasClass 'impressum'
      linkName = 'Impressum'
      imp = $('#impressum')
    if t.hasClass 'datenschutz'
      linkName = 'Datenschutz'
      imp = $('#datenschutz')

    if( imp.is(':hidden') )
      imp.show(1000)
      t.append(' (schließen)')
    else
      imp.hide(1000)
      t.html(linkName)
    return false

  $('#gallery').slick
    autoplay: true
    autoplaySpeed: 10000
    speed: 800
    dots: true
    slidesToShow: 1
    variableWith: true

  # if disableValidate == false
  $('#email').validate ->
    rules:
      name:
        required: true
        email: true
      email:
        required: true
        email: true
      message:
        required: true
    # submitHandler: allGood()

  $.validator.setDefaults({
    debug: true,
    success: "valid"
  });
  form = $( "#email" );
  form.validate();
  $( ".submit" ).click (e) ->
    e.preventDefault()
    if form.valid()
      # sendEmail()
      sendMailPHP()
    else
      $('#email .result').html('Please check that you filled out the form correctly and try again.')


  sendMailPHP = () ->
    $('#email .result').html "Sending email..."
    firma   = $('.firma').val()
    name    = $('.name').val()
    strasse = $('.strasse').val()
    plz     = $('.plz').val()
    telefon = $('.telefon').val()
    email   = $('.email').val()
    message = $('.message').val()
    theEmail = 'Name: ' + name + "\nFirma: " + firma + " \nAddresse: " + strasse + " " + plz + " \nTelefon: " + telefon + " \nE-mail: " + email + "\n" + "Nachricht: " + message

    # console.log theEmail

    $.ajax
      url: '/mailer/mailer.php'
      method: 'POST'
      data:
        message: theEmail
        email: email
        name: name
      dataType: "json"
      error: (data) ->
        theResponse = JSON.stringify(data)
        $('#email .result').html "Error:<br/>#{theResponse}"
      success: (data) ->
        theResponse = JSON.stringify(data)
        $('#email .result').html "Vielen Dank. E-mail gesendet!"
      # error: (data) ->
      #   theResponse = JSON.stringify(data)
      #   $('#email .result').html "AJAX Error: #{theResponse}"

  # if disableGoogleMaps == false
  mapInit()

  # closed height set in section3.jade

  $('.fold').each ->
    closedH = $(this).data('closed')
    openH = $(this).height()
    $(this).data('openH', openH).height(closedH)


  $('.toggle.open').click ->
    col = $(this).closest('._col')
    fold = col.find('.fold')
    openH = fold.data('openH')
    fold.height(openH)
    $(this).hide()
    col.find('.close').show()
  $('.toggle.close').click ->
    col = $(this).closest('._col')
    fold = col.find('.fold')
    closedH = fold.data('closed')
    fold.height(closedH)
    $(this).hide()
    col.find('.open').show()

  url = window.location.pathname;
  if (/en/i.test(url))
    # is english
    $('.lang a.active').removeClass('active')
    $('.lang a:eq(1)').addClass('active')

mapDrag = true
if( /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) )
  mapDrag = false


mapInit = ->
  mapOptions =
    zoom: 16
    center: new (google.maps.LatLng)(52.5237938,13.4018449)
    disableDoubleClickZoom: true
    scrollwheel: false
    draggable: mapDrag
    styles:
      [
        {
          "featureType": "water",
          "elementType": "geometry.fill",
          "stylers": [
            { "saturation": 0.5 },
            { "color": "#DDEEFF" }
          ]
        }
        {
          'featureType': 'transit'
          'elementType': 'geometry.stroke'
          'stylers': [
            { 'color': '#aaaaaa' }
            { 'visibility': 'on' }
          ]
        }
        {
          'featureType': 'transit'
          'elementType': 'labels.text.fill'
          'stylers': [
            { 'saturation': 0 }
            { 'color': '#777777' }
          ]
        }

        {
          'featureType': 'road.highway'
          'elementType': 'geometry.stroke'
          'stylers': [
            { 'visibility': 'on' }
            { 'color': '#b3b3b3' }
          ]
        }
        {
          'featureType': 'road.highway'
          'elementType': 'geometry.fill'
          'stylers': [ { 'color': '#ffffff' } ]
        }
        {
          'featureType': 'road.local'
          'elementType': 'geometry.fill'
          'stylers': [
            { 'visibility': 'on' }
            { 'color': '#ffffff' }
            { 'weight': 1.8 }
          ]
        }
        {
          'featureType': 'road.local'
          'elementType': 'geometry.stroke'
          'stylers': [ { 'color': '#d7d7d7' } ]
        }
        {
          'featureType': 'poi'
          'elementType': 'geometry.fill'
          'stylers': [
            { 'visibility': 'off' }
            { 'color': '#ebebeb' }
          ]
        }
        {
          'featureType': 'administrative'
          'elementType': 'geometry'
          'stylers': [ { 'color': '#a7a7a7' } ]
        }
        {
          'featureType': 'road.arterial'
          'elementType': 'geometry.fill'
          'stylers': [ { 'color': '#ffffff' } ]
        }
        {
          'featureType': 'landscape'
          'elementType': 'geometry.fill'
          'stylers': [
            { 'visibility': 'on' }
            { 'color': '#efefef' }
          ]
        }
        {
          'featureType': 'road'
          'elementType': 'labels.text.fill'
          'stylers': [ { 'color': '#696969' } ]
        }
        {
          'featureType': 'administrative'
          'elementType': 'labels.text.fill'
          'stylers': [
            { 'visibility': 'on' }
            { 'color': '#737373' }
          ]
        }
        {
          'featureType': 'poi'
          'elementType': 'labels.icon'
          'stylers': [ { 'visibility': 'on' } ]
        }
        {
          'featureType': 'poi'
          'elementType': 'labels'
          'stylers': [ { 'visibility': 'on' } ]
        }
        {
          'featureType': 'road.arterial'
          'elementType': 'geometry.stroke'
          'stylers': [ { 'color': '#d6d6d6' } ]
        }
        {
          'featureType': 'road'
          'elementType': 'labels.icon'
          'stylers': [ { 'visibility': 'off' } ]
        }
        {
          'featureType': 'poi'
          'elementType': 'geometry.fill'
          'stylers': [ { 'color': '#dadada' } ]
        }
      ]
  mapElement = document.getElementById('map')
  map = new (google.maps.Map)(mapElement, mapOptions)

  image =
    url: '/img/dpf50.png'
    size: new (google.maps.Size)(50,43)
    origin: new (google.maps.Point)(0, 0)
    anchor: new (google.maps.Point)(30, 40)

  logoMarker = new (google.maps.Marker)(
    position: new (google.maps.LatLng)(52.5237938,13.4018449)
    map: map
    icon: image)


  return
