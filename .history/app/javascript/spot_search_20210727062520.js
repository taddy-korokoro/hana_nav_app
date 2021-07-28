$(function () {
  $(".spot_search_result").on("click", ".list-group-item", function (event) {
    const spot_data = event.target.dataset.spotName || event.target.dataset.spotLocation;
    $("#spot_search").val(spot_data);
  });

  function addSpot(spot) {
    let html = `
    <ul class="list-group">
      <li class="list-group-item
        data-spot-name = "${ spot.name }"
        data-spot-location = "${ spot.location }"
      >
        ${spot.name || spot.location}</li>
    </ul>
    `;
    $(".spot_search_result").append(html);
  };

  function addNoSpot() {
    let html = `該当のスポットがありません`
    $(".spot_search_result").append(html);
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
        $(".spot_search_result").empty();
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