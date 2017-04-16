var SnackManager = (function(){
  $(document).ready(function(){
    //this does all the live updating for the page to make it responsive

    //it updates the vote count and hides the vote button on click

    //then when the vote registers it updates how many votes the user has available

    //the button should never be present when the user has already voted.
    $(".vote-button").on("click", function(event){
        $("#" + event.target.id).hide()
        $("#" + event.target.id + "-hidden").removeClass() 
        var value = $("#" + event.target.id + "-votes").text()
        $("#" + event.target.id + "-votes").text(parseInt(value)  + 1)
    })

    $(document).ajaxSuccess(
      function(event, xhr, status, error) {
        $("#vote-count").text(xhr.responseJSON.return)
      }).ajaxError(
      function(event, xhr, status, error) {

        $("#vote-box").html("<strong> " + xhr.responseJSON.errors +" </strong>")
        $(".panel").attr( "class", "panel panel-danger")
      })
  });

})();