$(function () {
  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
        $("#img_prev_1").attr('src', e.target.result);
        $("#img_prev_2").attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }
  $("#image-select-btn").change(function () {
    readURL(this);
  });
});