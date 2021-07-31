$(document).on('turbolinks:load', function () { //リロードしなくてもjsが動くようにする
  $(document).on('keyup', '#form', function (e) {
    e.preventDefault();
    var input = $.trim($(this).val());
    //ここから追記
    $.ajax({ //ajax通信で以下のことを行います
        url: '/travel_records/search', //urlを指定
        type: 'GET', //メソッドを指定
        data: ('keyword=' + input), //コントローラーに渡すデータを'keyword=input(入力された文字のことですね)'にするように指定
        processData: false, //おまじない
        contentType: false, //おまじない
        dataType: 'json' //データ形式を指定
      })
      .done(function (data) { //データを受け取ることに成功したら、dataを引数に取って以下のことする(dataには@usersが入っている状態ですね)
        $('#result').find('li').remove(); //idがresultの子要素のliを削除する
        $(data).each(function (i, spot) { //dataをuserという変数に代入して、以下のことを繰り返し行う(単純なeach文ですね)
          $('#result').append('<li>' + spot.name + '</li>') //resultというidの要素に対して、<li>ユーザーの名前</li>を追加する。
        });
      })
  });
});

$(function () {
  function addSpot(spot) {
    let html = `
    <a href="/spots/${spot.id} class="spot_search-list">
      <div>${spot.name} - ${spot.location}</div>
    </a>
    `;
    $("spot_search_result").append(html);
  };

  function addNoSpot() {
    let html = `該当のスポットがありません`
    $("#shop_search_result").append(html);
  };
  $("spot_search").on("keyup", function () {
    let input = $("spot_search").val();
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