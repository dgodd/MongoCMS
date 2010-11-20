// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function() {
  $('div#file-uploader').each(function(div) {
    var uploader = new qq.FileUploader({
      // pass the dom node (ex. $(selector)[0] for jQuery users)
      element: document.getElementById('file-uploader'),
      // path to server-side upload script
      action: '/pages/4cddde0d9a779b3e3f000008/add_asset'
    })
  });
  $('td#dropzone img').draggable({ appendTo: "body", helper: "clone" });
  $('textarea').droppable({ drop: function(e,ui) {
    var img = ui.draggable.data('textile');
    if(img && img!='') {
      insertAtCursor(this, img);
      $(this).focus();
    }
  }});
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
