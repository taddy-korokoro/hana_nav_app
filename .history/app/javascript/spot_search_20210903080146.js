function closeBtn() {
  $('.modal-footer').show();
  $('#close_btn').click(function () {
    $('#spot_search_form').val('');
    $('.js-spotName').text("スポット名・住所を入力してください");
  });
}

$(function () {
  $('#label,#spot_select_form').hide();
  $('#spot_select_form').on('click', '.js-listItem', function (event) {
    const spot_data = event.target.dataset.spotName || event.target.dataset.spotLocation;
    const spot_id = event.target.value;
    $('#spot_search_form').val(spot_data);
    $('#spot_id').val(spot_id);
    $('.js-spotName').text(spot_data);
    $('#Modal').modal('hide');
  });

  function addSpot(spot) {
    $('.modal-footer').hide();
    $('#label, #spot_select_form').show();
    let html = `
      <option class='js-listItem'
        value = '${spot.id}'
        data-spot-name = '${ spot.name }'
        data-spot-location = '${ spot.location }'
      >
        ${spot.name || spot.location}</option>
    `;
    $('#spot_select_form').append(html);
  };

  function addNoSpot(message) {
    let html = `${message}`
    $('#no_spot').append(html);
    closeBtn();
  };
  $('#spot_search_form').on('keyup', function () {
    let input = $('#spot_search_form').val();
    $.ajax({
        type: 'GET',
        url: '/travel_records/search',
        data: {
          keyword: input
        },
        dataType: 'json'
      })
      .done(function (spots) {
        $('#no_spot').empty();
        $('#spot_select_form').empty();
        $('#label,#spot_select_form').hide();
        if (spots.length !== 0) {
          spots.forEach(function (spot) {
            addSpot(spot);
          });
        } else if (input.length == 0) {
          $('#label,#spot_select_form').hide();
          $('.modal-footer').show();
          $('#close_btn').click(function () {
            $('#spot_search_form').val('');
            $('.js-spotName').text("スポット名・住所を入力してください");
          })
          return false;
        } else {
          addNoSpot("該当するスポットはありません");
        }
      })
  });
});