$(function () {
  $("#exampleFormControlSelect2").on("click", "#exampleFormControlSelect2-item", function (event) {
    console.log(event.target.dataset.spotName);
    console.log(event.target.dataset.spotLocation);
    const spot_data = event.target.dataset.spotName || event.target.dataset.spotLocation;
    $("#spot_search").val(spot_data);
    $("#exampleFormControlSelect2").empty();
  });

  function addSpot(spot) {
    let html = `
      <option
        data-spot-name = "${ spot.name }"
        data-spot-location = "${ spot.location }"
      >
        ${spot.name || spot.location}</option>
    `;
    $("#exampleFormControlSelect2").append(html);
  };

  function addNoSpot() {
    let html = `該当のスポットがありません`
    $("#exampleFormControlSelect2").append(html);
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
        $("#exampleFormControlSelect2").empty();
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