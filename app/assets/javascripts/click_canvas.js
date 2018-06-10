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
