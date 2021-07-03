// 投稿画像のプレビュー機能
$(function () {
  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
        $("#img_prev_1").attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }

  $("#image-select-btn_1").change(function () {
    readURL(this);
  });
});
$(function () {
  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
        $("#img_prev_2").attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }

  $("#image-select-btn_2").change(function () {
    readURL(this);
  });
});
$(function () {
  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
        $("#img_prev_3").attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }

  $("#image-select-btn_3").change(function () {
    readURL(this);
  });
});

// プロフィール画像のプレビュー機能
$(function () {
  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
        $("#profile_img_prev").attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }

  $("#image-select-btn").change(function () {
    readURL(this);
  });
});

$(function () {
  $('#img_2').hide();
  $('#image-select-btn_1').click(function () {
    $('#img_2').show('slow');
  })
});
$(function () {
  $('#img_3').hide();
  $('#image-select-btn_2').click(function () {
    $('#img_3').show();
  })
});