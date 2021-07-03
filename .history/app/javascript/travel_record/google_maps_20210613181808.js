javascript:
  function initMap() {
    var test = {
      lat: #{
        travel_record.latitude
      },
      lng: #{
        travel_record.longitude
      }
    };
    var map = new google.maps.Map(document.getElementById('map'), {
      zoom: 15,
      center: test
    });
    var transitLayer = new google.maps.TransitLayer();
    transitLayer.setMap(map);

    var contentString = "住所：#{travel_record.place}";
    var infowindow = new google.maps.InfoWindow({
      content: contentString
    });

    var marker = new google.maps.Marker({
      position: test,
      map: map,
      title: contentString
    });

    marker.addListener('click', function () {
      infowindow.open(map, marker);
    });
  }

script src = "https://maps.googleapis.com/maps/api/js?v=3.exp&key=#{ENV['GOOGLE_MAP_API']}&callback=initMap"
async defer