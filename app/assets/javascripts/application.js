// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require jquery.tablesorter.min
//= require_tree .

function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $(link).parent().before(content.replace(regexp, new_id));
}

$(function() {
 iconize($(".editlink"), "pencil", "Edit");
 iconize($(".destroylink"), "trash", "Delete");
 $("#addPlayerButton").click(function() {
  $("#addPlayer").slideDown();
  $("#addPlayerButton").hide();
  });

  $(".table").tablesorter();
  updategoals();
});

function iconize(element, icon, text){
	element.prepend('<i class="icon-'+icon+'"></i>  ');
	element.children().attr("title", text);
}

function updategoals(){
  var scored = $(".scored");
  var suffered = $(".suffered");

  var scorecount = 0;
  var sufferedcount = 0;
  $.each(scored, function(index, value) { 
    if(value.innerHTML === "1")
        scorecount ++;
  });

  $.each(suffered, function(index, value) { 
    if(value.innerHTML === "1")
      sufferedcount ++;
  });

  $("#scoredCount").html('<span id=scoredCount>'+scorecount+'</span>');
  $("#sufferedCount").html('<span id=sufferedCount>'+sufferedcount+'</span>');
}