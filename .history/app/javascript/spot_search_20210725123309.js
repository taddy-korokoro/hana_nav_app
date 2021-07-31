$(function () {
  function addSpot(spot) {
    let html = `
    <a href="/spots/${spot.id}", class="spot-search-list">
      <div>${spot.name} - ${spot.location}</div>
    </a>
    `;
    $("#spot_search_result").append(html);
  };

  function addNoSpot() {
    let html = `該当のスポットがありません`
    $("#shop_search_result").append(html);
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
        $("#spot_search_result").empty();
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