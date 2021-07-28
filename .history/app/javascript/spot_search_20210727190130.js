$(function () {
  $("#select_form").on("click", ".list-item", function (event) {
    $("#label").show();
    const spot_data = event.target.dataset.spotName || event.target.dataset.spotLocation;
    $("#spot_search").val(spot_data);
    $("#select_form").hide();
  });

  function addSpot(spot) {
    let html = `
      <option class="list-item"
        data-spot-name = "${ spot.name }"
        data-spot-location = "${ spot.location }"
      >
        ${spot.name || spot.location}</option>
    `;
    $("#select_form").append(html);
  };

  function addNoSpot() {
    let html = `該当のスポットがありません`
    $("#select_form").append(html);
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
        $("#select_form").empty();
        if (spots.length !== 0) {
          spots.forEach(function (spot) {
            addSpot(spot);
          });
        } else if (input.length == 0) {
          return false;
        } else {
          addNoSpot();
        }
      })
  });
});