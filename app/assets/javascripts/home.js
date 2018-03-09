$(document).ready(function(){
  $('#btn-search').click(function() {
    // TODO
    var params = {};
    params['visitor_uuid'] = $('#visitor_uuid').data('visitor');
    params['adults'] = 3;
    params['children'] = 4;
    params['infants'] = 3;
    params['price_min'] = 1134418;
    params['price_max'] = 6742061;
    params['room_types'] = 'Entire home/apt';
    // params['room_types'] = 'Private room';
    // params['room_types'] = 'Shared room';
    params['min_beds'] = 2;
    params['min_bedrooms'] = 2;
    params['min_bathrooms'] = 2;
    params['query'] = 'Toyama';
    // end TODO

    App.Home.crawler(params);
    return false;
  });
});