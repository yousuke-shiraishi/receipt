edit_picture = function qqq() {
  var img = new Image();
  var flg = true;
  var flg2 = false;
  var first_x = null;
  var first_y = null;
  var last_x = null;
  var last_y = null;
  var base1 = null;
  img.src = gon.picture + "?" + new Date().getTime();
  var canvas = document.getElementById('screen');
  if (canvas && canvas.getContext) {
    var ctx = canvas.getContext('2d');
    img.onload = function() {
      ctx.drawImage(img, 0, 0);

      document.getElementById('custom_image').value = "";
      canvas.addEventListener("click", first_click, false);
      canvas.addEventListener("click", fill_rect, false);
      console.log("ベースネーム１" + document.getElementById('custom_image').value);
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
        base1 = canvas.toDataURL('image/png');
        console.log("ベースネーム２" + base1);
      //  console.log("ドキュメント" + document.getElementById('image').src);
        document.getElementById('custom_image').value = base1;
        console.log("ベースネーム3" + document.getElementById('custom_image').value);
      }
    };
  }
};
