$(function () {
  $("#label,#select_form").hide();
  $("#select_form").on("click", ".list-item", function (event) {
    const spot_data = event.target.dataset.spotName || event.target.dataset.spotLocation;
    $("#spot_search").val(spot_data);
    $(".spot_name").text(spot_data);
    $('#Modal').modal('hide');
  });

  function addSpot(spot) {
    $("#label, #select_form").show();
    let html = `
      <option class="list-item"
        data-spot-name = "${ spot.name }"
        data-spot-location = "${ spot.location }"
      >
        ${spot.name || spot.location}</option>
    `;
    $("#select_form").append(html);
  };

  function addNoSpot(message) {
    let html = `${message}`
    $(".no-spot").append(html);
  };
  $("#spot_search").on("keyup", function () {
    let input = $("#spot_search").val();
    $.ajax({
        type: 'GET',
        url: '/travel_records/search',
        data: {
          keyword: input
        },
        dataType: 'json'
      })
      .done(function (spots) {
        $(".no-spot").empty();
        $("#select_form").empty();
        $("#label,#select_form").hide();
        if (spots.length !== 0) {
          spots.forEach(function (spot) {
            addSpot(spot);
          });
        } else if (input.length == 0) {
          $("#label,#select_form").hide();
          return false;
        } else {
          addNoSpot("該当するスポットはありません");
        }
      })
  });
});