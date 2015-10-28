$(document).ready(function () {
  $("#new_word").submit(function () {
    var hiddens = $("input:hidden")
    for (var i = hiddens.length - 1; i >= 0; i--) {
      if ($(hiddens[i]).val() == "true") {
        return true
      }
    }
    alert("Please choose a correct answer")
    return false
  })
})

function make_correct_field (radio_btn) {
  $(".answer_field").each(function () {
    $(this).prev().val(false)
  })
  if($(radio_btn).prop("checked")) {
    $(radio_btn).prev().val(true)
  }
}