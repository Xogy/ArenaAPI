$(function(){
    function display(bool) {
        if (bool) {
            $("#body").show();		
        } else { 
            $("#body").hide();
        }
    }
    display(false);

	window.addEventListener('message', function(event) {
		var item = event.data;
		if (item.type === "ui"){
			display(item.status);
			$("#seconds").text("Waiting for people");
		}

		if (item.type === "arenaName"){
			$("#arenaName").text(item.arenaName);
		}
		
		if (item.type === "updateTime"){
			$("#seconds").text("Wait please: "+ item.time +" seconds");
		}
		
		if (item.type === "playerNameList"){
			$("#players").text("");
            for (var index in item.Names) {
			    $("#players").append("<div class = 'box'><i class='fas fa-user-alt'></i> " + item.Names[index] + "</div>");
			}
		}
	})
	
});