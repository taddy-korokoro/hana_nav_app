$(function () {
  $("#label").hide();
  $("#select_form").hide();
  $("#select_form").on("click", ".list-item", function (event) {
    const spot_data = event.target.dataset.spotName || event.target.dataset.spotLocation;
    $("#spot_search").val(spot_data);
    $("#select_form").hide();
  });

  function addSpot(spot) {
    $(".message").hide();
    $("#label").show();
    $("#select_form").show();
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
    $("#label").hide();
    $("#select_form").hide();
    let html = `
      <div>${message}</div>
    `;
    $(".message").append(html);
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
        } else {
          addNoSpot("該当するスポットはありません");
        }
      })
  });
});