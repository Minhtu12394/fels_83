function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1")
  var parent = $(link).parents(".fields")
  parent.hide()
  parent.find("input:radio").prev().val(false)
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime()
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id))
}
