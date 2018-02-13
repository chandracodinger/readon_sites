/*jQuery*/

$(function(){
  var ua =navigator.userAgent;
  if(ua.indexOf('iPhone') > -1 || ua.indexOf('iPad') > -1 || ua.indexOf('iPod')  > -1){
    var start = "touchstart";
    var move  = "touchmove";
    var end   = "touchend";
  } else{
    var start = "mousedown";
    var move  = "mousemove";
    var end   = "mouseup";
  }
  var ink, d, x, y;
  $(".ripplelink").on(start, function(e){
    if($(this).find(".ink").length === 0){
        $(this).prepend("<span class='ink'></span>");
    }
         
    ink = $(this).find(".ink");
    ink.removeClass("animate");
     
    if(!ink.height() && !ink.width()){
        d = Math.max($(this).outerWidth(), $(this).outerHeight());
        ink.css({height: d, width: d});
    }
     
    x = e.originalEvent.pageX - $(this).offset().left - ink.width()/2;
    y = e.originalEvent.pageY - $(this).offset().top - ink.height()/2;
     
    ink.css({top: y+'px', left: x+'px'}).addClass("animate");
});
});