$(document).ready(function () {
  $("#new_word").submit(function () {
    if ($('input:checkbox:checked').length) {
      alert("Please choose a correct answer")
      return false
    }
    return true
  })

  $("body").on("DOMNodeInserted", function () {
    $(".answer_field").click(function () {
      $(".answer_field").not(this).attr("checked", false)
    })
  })
})
