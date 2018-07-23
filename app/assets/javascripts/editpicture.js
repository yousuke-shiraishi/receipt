edit_picture = function edit_picture() {
  var img = new Image();
  var flg = true;
  var flg2 = false;
  var first_x = null;
  var first_y = null;
  var last_x = null;
  var last_y = null;
  var base1 = null;
  var data =null;
  img.src = gon.picture + "?" + new Date().getTime();
  var canvas = document.getElementById('screen_image');
  if (canvas && canvas.getContext) {
    var ctx = canvas.getContext('2d');
    img.onload = function() {
      ctx.drawImage(img,0,0,300,300 * img.height / img.width);

      document.getElementById('custom_image').value = "";
      canvas.addEventListener("click", first_click, false);
      canvas.addEventListener("click", fill_rect, false);
      // $('#custom_image').fileupload({ formData: { file: data }});
      // $('#custom_image').fileupload('add', { files: [ data ] });
    };

    first_click = function(e) {
      var rect = e.target.getBoundingClientRect();
      if (flg) {
        first_x = e.clientX - rect.left;
        first_y = e.clientY - rect.top;
        flg = false;
      } else {
        last_x = e.clientX - rect.left;
        last_y = e.clientY - rect.top;
        flg = true;
        flg2 = true;
      }
    };

    fill_rect = function(){
      let CSRF_TOKEN = $('meta[name = "csrf-token"]').attr('content');
      if (flg2 === true) {
        if (first_x > last_x) {
          [first_x, last_x] = [last_x, first_x]
        }
        if (first_y > last_y) {
          [first_y, last_y] = [last_y, first_y]
        }
        ctx.fillStyle = "rgb(0, 0, 0)";
        ctx.fillRect(first_x, first_y, last_x - first_x, last_y - first_y);
        flg2 = false;
        data = canvas.toDataURL('image/png');
        document.getElementById('custom_image').value = data;
        $('#custom_image').fileupload({ formData: { file: data }});
        $('#custom_image').fileupload('add', { files: [ data ] });
      }
    };
  }
};
