$(document).ready(function () {
  $(".category-name").each(function (){
    var name = $(this).html()
    if (name.length > 40) {
      name = name.substr(0, 40) + " ..."
    }
    $(this).html(name)
  })

  $(".category-description").each(function (){
    var description = $(this).html()
    if (description.length > 120) {
      description = description.substr(0, 120) + " ..."
    }
    $(this).html(description)
  })
})
