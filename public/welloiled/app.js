$(function() {
  var wrapWidth;
	var fcenter = function() {
		var h = $(window).height();
		if(h>670) {
			$('div#wrap2').css({ 'marginTop':((h - 670)/2)+'px' });
			$('div#wrapper, div#limg').css({ 'height':'640px' });
			$('div#content').css({ 'height':'600px' });
			$('body').css({ 'overflow-y':'hidden' });
		} else {
			$('div#wrap2').css({ 'marginTop':'10px' });
			$('div#wrapper, div#limg').css({ 'height':(h - 30)+'px' });
			$('div#content').css({ 'height':(h - 70)+'px' });
			$('body').css({ 'overflow-y':'hidden' });
		}

		var w = $(window).width();
		if(w > 940) {
      wrapWidth = (w - 30) + 'px';
			$('div#wrap2, div#wrapper').css('width', (w - 30));
			$('div#content').css('width', (w - 30 - 480));
		} else {
      wrapWidth = '910px';
			$('div#wrap2, div#wrapper').css('width', 910)
			$('div#content').css('width', 430);
		}
	};
	fcenter(); $(window).bind('resize', fcenter);

	$('div#nav ul li:not(.curr)').live('mouseover', function() {
		var a = $(this).find('a');
		a.stop(false,false).animate({ 'opacity':0 }, 200,
			function() { a.addClass('hover') }).animate({ 'opacity':1 }, 200);
	}).live('mouseout', function() {
		var a = $(this).find('a');
		a.stop(false,false).animate({ 'opacity':0 }, 200,
			function() { a.removeClass('hover') }).animate({ 'opacity':1 }, 200);
	});


  var wrap = $('#wrapper');
  if($.support.pjax) {
    $('a').pjax('#content').live('click', function(){
      var a = $(this);
      if(a.parents('div#nav')[0]) {
        $('div#nav ul li a').removeClass('curr');
        a.addClass('curr');
      }
      return false;
    });
    $('#content').bind('pjax:start', function() { $('#content').css({ 'opacity': 0.2 }); });
    $('#content').bind('pjax:end', function() { $('#content').css({ 'opacity': 1.0 }); });
  } else {
    $('div#nav ul li a').live('click', function() {
      var a = $(this);
      var limg = a.attr('rel');
      $('div#nav ul li a').removeClass('curr');
      a.addClass('curr');
      var cwidth = wrap.width()+'px';
      wrap.animate({ 'width':'230px' }, function() {
        if(limg) $('div#limg').css({ 'background-image':'url('+limg+')' });
      });
      $('div#content').load(a.attr('href'), function() {
        wrap.animate({ 'width':cwidth });
      });
      return false;
    });
  }


});

