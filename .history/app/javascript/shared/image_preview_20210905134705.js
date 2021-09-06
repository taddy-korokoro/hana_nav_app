// 投稿画像のプレビュー機能
$(function () {
  $('#file_btn_1').on('change', function (e) {
    var reader = new FileReader();
    reader.onload = function (e) {
      $('#img_prev_1').attr('src', e.target.result);
    }
    reader.readAsDataURL(e.target.files[0]);
    $('#img_2').show();
  });
});

// var reader = new FileReader();
// reader.onload = function (e) {
//   $('#img_prev_1').attr('src', e.target.result);
// }
// reader.readAsDataURL(e.target.files[0]);

$(function () {
  $('#file_btn_2').on('change', function (e) {
    var reader = new FileReader();
    reader.onload = function (e) {
      $('#img_prev_2').attr('src', e.target.result);
    }
    reader.readAsDataURL(e.target.files[0]);
    $('#img_3').show();
  });
});
$(function () {
  $('#file_btn_3').on('change', function (e) {
    var reader = new FileReader();
    reader.onload = function (e) {
      $('#img_prev_3').attr('src', e.target.result);
    }
    reader.readAsDataURL(e.target.files[0]);
  });
});


// プロフィール画像のプレビュー機能
$(function () {
  $('#file_btn').on('change', function (e) {
    var reader = new FileReader();
    reader.onload = function (e) {
      $('#profile_img_prev').attr('src', e.target.result);
    }
    reader.readAsDataURL(e.target.files[0]);
  });
});