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
  }
};
