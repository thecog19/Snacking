var SnackManager = (function(){
  $(document).ready(function(){
    console.log("hi")
    $(document).ajaxSuccess(
      function(event, xhr, status, error) {
        $("#vote-count").text(xhr.responseJSON.return)
      }).ajaxError(
      function(event, xhr, status, error) {
        $("#vote-box").html("<strong> You are out of votes </strong>")
        $(".panel").attr( "class", "panel panel-danger")
      })
  });

})();