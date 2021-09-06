// 投稿画像のプレビュー機能
// $(function () {
//   function readURL(input) {
//     if (input.files && input.files[0]) {
//       var reader = new FileReader();
//       reader.onload = function (e) {
//         $("#img_prev_1").attr('src', e.target.result);
//       }
//       reader.readAsDataURL(input.files[0]);
//     }
//   }
//   $("#image-select-btn_1").change(function () {
//     readURL(this);
//     $('#img_2').show();
//   });
// });
// $(function () {
//   function readURL(input) {
//     if (input.files && input.files[0]) {
//       var reader = new FileReader();
//       reader.onload = function (e) {
//         $("#img_prev_2").attr('src', e.target.result);
//       }
//       reader.readAsDataURL(input.files[0]);
//     }
//   }
//   $("#image-select-btn_2").change(function () {
//     readURL(this);
//     $('#img_3').show();
//   });
// });
// $(function () {
//   function readURL(input) {
//     if (input.files && input.files[0]) {
//       var reader = new FileReader();
//       reader.onload = function (e) {
//         $("#img_prev_3").attr('src', e.target.result);
//       }
//       reader.readAsDataURL(input.files[0]);
//     }
//   }
//   $("#image-select-btn_3").change(function () {
//     readURL(this);
//   });
// });

$(function () {
  for (var i = 1; i < 4; i++) {
    reader[i] = new FileReader();
    reader[i].onload = finisher(i, e);
    reader[i].readAsDataURL(e.target.files[i]);

    function finisher(i, e) {
      return function (e) {
        $(`#img_prev_${i}`).attr('src', e.target.result);
      }
    }

    // $(`#file_btn_${i}`).on('change', function (e) {
    //   var reader = new FileReader();
    //   reader.onload = function (e) {
    //     $(`#img_prev_${i}`).attr('src', e.target.result);
    //   }
    //   reader.readAsDataURL(e.target.files[0]);
    // $(`#img_${i + 1}`).show();
    // });
    // function readURL(input) {
    //   if (input.files && input.files[0]) {
    //     var reader = new FileReader();
    //     reader.onload = function (e) {
    //       $(`#img_prev_${i}`).attr('src', e.target.result);
    //       console.log(e.target.result);
    //     }
    //     reader.readAsDataURL(input.files[0]);
    //   }
    // }
    // $(`#image-select-btn_${i}`).change(function () {
    //   readURL(this);
    //   $(`#img_${i + 1}`).show();
    // });
  }
});

// プロフィール画像のプレビュー機能
// $(function () {
//   function readURL(input) {
//     if (input.files && input.files[0]) {
//       var reader = new FileReader();
//       reader.onload = function (e) {
//         $("#profile_img_prev").attr('src', e.target.result);
//       }
//       reader.readAsDataURL(input.files[0]);
//     }
//   }

//   $("#image-select-btn").change(function () {
//     readURL(this);
//   });
// });
$(function () {
  $('#file_btn').on('change', function (e) {
    var reader = new FileReader();
    reader.onload = function (e) {
      $('#profile_img_prev').attr('src', e.target.result);
    }
    reader.readAsDataURL(e.target.files[0]);
  });
});