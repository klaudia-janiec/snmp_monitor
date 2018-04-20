$(document).ready(function() {

  var curPage = 0;
  var numOfPages = $("[class^=page]").length;
  var animTime = 1000;
  var scrolling = false;
  var pgPrefix = ".page-";
  var pageNumAgentIdMapper = mapPageNumToAgentIds();

  function mapPageNumToAgentIds() {
    var mapper = {};

    $.ajax({
      url: "/agents/",
      dataType: "json",
      success: function(data) {
        for (var i in data["systems_overview"]) {
          mapper[parseInt(i) + 1] = data["systems_overview"][i]["id"]
        }
      }
    });

    return mapper;
  }

  function pagination() {
    scrolling = true;

    $(pgPrefix + curPage).removeClass("inactive").addClass("active");
    $(pgPrefix + (curPage - 1)).addClass("inactive").removeClass("active");
    $(pgPrefix + (curPage + 1)).addClass("inactive").removeClass("active");
    refreshCurrentAgentData();

    setTimeout(function() {
      scrolling = false;
    }, animTime);
  };

  function navigateUp() {
    if (curPage === 0) return;
    curPage--;
    pagination();
  };

  function navigateDown() {
    if (curPage === numOfPages - 1) return;
    curPage++;
    pagination();
  };

  $(document).on("mousewheel DOMMouseScroll", function(e) {
    if (scrolling) return;
    if (e.originalEvent.wheelDelta > 0 || e.originalEvent.detail < 0) {
      navigateUp();
    } else {
      navigateDown();
    }
  });

  $(document).on("keydown", function(e) {
    if (scrolling) return;
    if (e.which === 38) {
      navigateUp();
    } else if (e.which === 40) {
      navigateDown();
    }
  });

  function refreshCurrentAgentData() {
    if(curPage == 0) {
      return;
    }

    $.ajax({
      url: "/agents/" + pageNumAgentIdMapper[curPage],
      dataType: "json",
      success: function(data){
        for (var property in data) {
          if (data.hasOwnProperty(property)) {
            if (property === "system_information") {
              $("#" + property).text(data[property])
            } else if ($.inArray(property, ["user_cpu_time", "system_cpu_time", "idle_cpu_time"]) >= 0) {
              $("#" + property).text(data[property] + " %")
            } else {
              $("#" + property).text(Math.round(data[property] * 100 / 1000000) / 100 + " GB")
            }
          }
        }
      }
    });
  }

  $("#refresh").click(refreshCurrentAgentData);
  setInterval(refreshCurrentAgentData, 5000);
});
