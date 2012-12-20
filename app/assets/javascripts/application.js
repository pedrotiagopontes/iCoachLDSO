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

 $("#new-note").click(function() {
  $(".new_note").show('slow');
  });

 var eventSelected = false;
 var playerSelected = false;
 $(".events").click(function() {
    $("#eventSelected").hide('slow');
    eventSelected = true;

    if(eventSelected && playerSelected){
      $("#submitEvent").show('slow');  
    }
  });

 $(".playerRadio").click(function() {
    $("#playerSelected").hide('slow');
    playerSelected = true;

    if(eventSelected && playerSelected){
      $("#submitEvent").show('slow');  
    }
  });

$(".selected-player").click(countSelected);
 

  $(".table").tablesorter();
  //updategoals();
  countSelected();

  var top = $('#total').offset().top - parseFloat($('#total').css('marginTop').replace(/auto/, 0));
   $(window).scroll(function (event) {
     // what the y position of the scroll is
     var y = $(this).scrollTop();
   
     // whether that's below the form
     if (y >= top) {
       // if so, ad the fixed class
       $('#total').addClass('fixed');
     } else {
       // otherwise remove it
       $('#total').removeClass('fixed');
     }
   });

});

function iconize(element, icon, text){
	element.prepend('<i class="icon-'+icon+'"></i>  ');
	element.children().attr("title", text);
}

function countSelected(){
  var chk = $(".selected-player"); 

  var selected = 0;
  var advanced = 0;
  var midfilder = 0;
  var defensive = 0;
  var gk = 0;
  var initial = 0;
  var bench = 0;

  chk.each(function() {
    if($(this).is(':checked') || $(this).val() == 1 || $(this).val() == 2){
      if($(this).parents(".player-row").children(".position").text() === "SA" || $(this).parents(".player-row").children(".position").text() === "Attacker"){
        advanced++;
      }
      if($(this).parents(".player-row").children(".position").text() === "Midfilder"){
        midfilder++;
      }
      if($(this).parents(".player-row").children(".position").text() === "Defender"){
        defensive++;
      }
      if($(this).parents(".player-row").children(".position").text() === "Goal Keeper"){
        gk++;
      }
      selected++;
       if($(this).val() == 1){
        initial++;
       }else if($(this).val() == 2){
        bench++;
       }
    }
  });

  $(".ntotal").html(selected);
  $(".ntotalAd").html(advanced);
  $(".ntotalMid").html(midfilder);
  $(".ntotalDe").html(defensive);
  $(".ntotalGk").html(gk);
  $(".ntotalInitial").html(initial);
  $(".ntotalBench").html(bench);

  if(initial === 11){
    $("#line-up-labelSelected").hide('slow')
  }else{
    $("#line-up-labelSelected").show('slow')
  }

  if(bench < 8){
    $("#line-up-labelBench").hide('slow')
  }else{
    $("#line-up-labelBench").show('slow')
  }

  if(initial === 11 && bench <8){
    $("#line-up-button").show('slow');
  }else{
    $("#line-up-button").hide('slow')
  }
}

function updategoals(){
  var scored = $(".scored");
  var suffered = $(".suffered");

  var scorecount = 0;
  var sufferedcount = 0;
  $.each(scored, function(index, value) { 
    if(value.innerHTML > 0){
      scorecount += parseInt(value.innerHTML, 10);
    }
  });

  $.each(suffered, function(index, value) { 
    if(value.innerHTML > 0){
      sufferedcount += parseInt(value.innerHTML, 10);
    }
  });

  $("#scoredCount").html(scorecount);
  $("#sufferedCount").html(sufferedcount);
}