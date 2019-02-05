$(document).ready(function() {

  $('#login-form').submit(function(e) {
    e.preventDefault();
    formData = $(e.currentTarget).serialize();
    attemptVerification(formData);
  })

  var doPoll = function() {
    $.get( "/profile/status", function(data) {
      if (data == 'approved') {
        window.location.href = "/account";
      } else if (data == 'denied') {
        window.location.href = "/sessions/fail";
      } else {
        setTimeout(checkForVeridium, 2000);
      }
    })
  };

  var attemptVerification = function(form) {
    $.post( "/sessions", form, function(data) {
      $('#veridium-modal').modal({backdrop:'static'},'show')
      if (data.success) {
        $('.auth-ot').fadeIn()
        checkForVeridium();
      } else {
        window.location.href = "/";
      }
    })
  };

  var checkForVeridium = function() {
    $.get( "/profile/status", function(data) {
      if (data == 'approved') {
        window.location.href = "/account";
      } else if (data == 'denied') {
        window.location.href = "/sessions/fail";
      } else {
        setTimeout(checkForVeridium, 2000);
      }
    })
  };

  doPoll()

})
