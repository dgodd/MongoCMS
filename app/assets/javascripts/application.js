//= require jquery
//= require jquery-ui
//= require_tree
//
// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function() {
  $('div#accordion-west ul.sortable').sortable({
    update: function(event,ui) {
      $.post('/pages/positions', $(this).sortable('serialize'));
    }
  });
  $('div#accordion-west ul.sortable').disableSelection();

  $('div#file-uploader').each(function(div) {
    var obj = this;
    var uploader = new qq.FileUploader({
      // pass the dom node (ex. $(selector)[0] for jQuery users)
      element: obj,
        // path to server-side upload script
        action: $(obj).attr('rel')
    })
  });
  /*`
    $('td#dropzone img').draggable({ appendTo: "body", helper: "clone" });
    $('textarea').droppable({ drop: function(e,ui) {
    var img = ui.draggable.data('textile');
    if(img && img!='') {
    insertAtCursor(this, img);
    $(this).focus();
    }
    }});
    */
  $('button.update').live('click', function() {
    $(this.parentNode.parentNode).find('form:first').submit();
  });
});

function insertAtCursor(myField, myValue) {
  //IE support
  if (document.selection) {
    myField.focus();
    sel = document.selection.createRange();
    sel.text = myValue;
  }
  //MOZILLA/NETSCAPE support
  else if (myField.selectionStart || myField.selectionStart == '0') {
    var startPos = myField.selectionStart;
    var endPos = myField.selectionEnd;
    myField.value = myField.value.substring(0, startPos)
      + myValue
      + myField.value.substring(endPos, myField.value.length);
  } else {
    myField.value += myValue;
  }
}
