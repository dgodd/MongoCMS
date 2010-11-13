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
});
