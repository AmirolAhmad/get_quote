var ready;
ready = function() {

  // Tooltip
  (function( $ ) {
  	'use strict';

  	if ( $.isFunction( $.fn['tooltip'] ) ) {
  		$( '[data-toggle=tooltip],[rel=tooltip]' ).tooltip({ container: 'body' });
  	}

  }).apply( this, [ jQuery ]);

  // table clickable
  $(".clickable-row").click(function() {
    window.document.location = $(this).data("url");
  });

};

$(document).ready(ready);
$(document).on('page:load', ready);
