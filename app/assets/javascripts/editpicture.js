function edit_picture() {
  var img = new Image();
  var flg = true;
  var flg2 = false;
  var first_x = null;
  var first_y = null;
  var last_x = null;
  var last_y = null;

  img.src = gon.picture+"?"+ new Date().getTime();
  var canvas = document.getElementById('screen');
  if(canvas && canvas.getContext){
    var ctx = canvas.getContext('2d');
    img.onload = function() {
    ctx.drawImage(img, 0, 0);

        first_click = function(e) {
          var rect = e.target.getBoundingClientRect();
          if(flg){
            console.log("e状態" + e);
            first_x = e.clientX - rect.left;
            console.log("first_x" + first_x);
            first_y = e.clientY - rect.top;
            console.log("first_y" + first_y);
            flg = false;
          } else{
            last_x = e.clientX - rect.left;
            console.log("last_x" + last_x);
            last_y = e.clientY - rect.top;
            console.log("last_y" + last_y);
            flg = true;
            flg2 = true;
        };
      }
        canvas.addEventListener("click",first_click,false);
        canvas.addEventListener("click",fill_rect,false);
      }


          // fill_rect();
          fill_rect = function fill_rect() {
          // //  var canvas = img.src;
          //  if (canvas.getContext) {
          if(flg2 === true){
          //   var ctx = canvas.getContext('2d');
          if(first_x > last_x){
            [first_x, last_x ] = [last_x, first_x ]
          }

          if(first_y > last_y){
            [first_y, last_y ] = [last_y, first_y ]
          }
              ctx.fillStyle = "rgb(0, 0, 0)";
            //  console.log(first_x+" "+first_y+" "+last_x - first_x+" "+last_y - first_y)
              ctx.fillRect(first_x, first_y, last_x - first_x, last_y - first_y);
              flg2 = false;
            }
         }
        //}
}

}
