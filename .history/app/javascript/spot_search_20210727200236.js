$(function () {
  $(".list-group").on("click", ".list-group-item", function (event) {
    console.log(event.target.dataset.spotName);
    console.log(event.target.dataset.spotLocation);
    const spot_data = event.target.dataset.spotName || event.target.dataset.spotLocation;
    $("#spot_search").val(spot_data);
    $(".list-group").empty();
  });

  function addSpot(spot) {
    let html = `
      <li class="list-group-item"
        data-spot-name = "${ spot.name }"
        data-spot-location = "${ spot.location }"
      >
        ${spot.name || spot.location}</li>
    `;
    $(".list-group").append(html);
  };

  function addNoSpot() {
    let html = `該当のスポットがありません`
    $(".list-group").append(html);
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
        $(".list-group").empty();
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