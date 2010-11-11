// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function(){
  $("input, textarea").labelify({ 'text':function(input) {
    var l = $('label[for="'+input.id+'"]');
    l.hide();
    return l.text();
  }, 'labelledClass':"labelHighlight" });
});
