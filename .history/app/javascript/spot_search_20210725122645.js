$(function () {
  function addShop(shop) {
    let html = `
      <a href="/shops/${shop.id} class="shop_search-list">
        <div>${shop.name} - ${shop.location}</div>
      </a>
      `;
    $("#shop_search--result").append(html);
  };

  function addNoShop() {
    let html = `ショップがありません`
    $("#shop_search--result").append(html);
  };
  $("#shop_search").on("keyup", function () {
    let input = $("#shop_search").val();
    $.ajax({
        type: 'GET',
        url: '/shops/search',
        data: {
          keyword: input
        },
        dataType: 'json'
      })
      .done(function (shops) {
        $("#shop_search--result").empty();

        if (shops.length !== 0) {
          shops.forEach(function (shop) {
            addShop(shop);
          });
        } else if (input.length == 0) {
          return false;
        } else {
          addNoShop();
        }
      })
  });
});

$(function () {
  function addSpot(spot) {
    let html = `
    <a href="/spots/${spot.id} class="spot-search-list">
      <div>${spot.name} - ${spot.location}</div>
    </a>
    `;
    $("spot_search_result").append(html);
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