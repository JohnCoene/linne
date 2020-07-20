Shiny.addCustomMessageHandler('line-inject', function(msg){
  $('#linne-injected-styles').append(msg);
})