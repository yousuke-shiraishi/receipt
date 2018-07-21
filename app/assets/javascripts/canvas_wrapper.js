$(document).ready(function() {
var w = $('.canvas_wrapper').width();
console.log("キャンバスの横の幅" + w);
var h = $('.canvas_wrapper').height();
console.log("キャンバスの縦幅" + h);
$('#screen_image').attr('width', w);
$('#screen_image').attr('height', h);
});
