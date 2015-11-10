var ready
ready = function () {
  $(".category-name").each(function (){
    var name = $(this).html()
    if (name.length > 20) {
      name = name.substr(0, 20) + " ..."
    }
    $(this).html(name)
  })

  $(".category-description").each(function (){
    var description = $(this).html()
    if (description.length > 80) {
      description = description.substr(0, 80) + " ..."
    }
    $(this).html(description)
  })
}

$(document).ready(ready)
$(document).on("page:load", ready)
