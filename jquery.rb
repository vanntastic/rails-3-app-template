file 'public/javascripts/application.js', <<-JS
function load_efx () {
  // body...
}

$(document).ready(function() {
  load_efx()
});

//setup the remote class
// use this version if using jquery < 1.3
// $('a.remote').click(function() {
$('a.remote').live('click', function(event){

  link = $(this).attr('href');

  $.ajax({
    type: "GET",
    url: link,
    dataType: "script"
  });

  return false;
});

jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")} 
})
JS

