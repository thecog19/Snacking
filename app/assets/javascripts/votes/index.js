var SnackManager = (function(){
  $(document).ready(function(){


    $(".vote-button").on("click", function(event){
        $("#" + event.target.id).hide()
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