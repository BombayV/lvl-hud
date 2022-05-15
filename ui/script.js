const updateHudPosition = (Minimap) => {
	console.log("Updating HUD position", Minimap);
}

window.addEventListener("load", () => {
	window.addEventListener("message", (e) => {
		switch (e.event.type) {
			case "updateHud":
				document.getElementById("health").style.width = `${e.event.health}%`;
				document.getElementById(("shield").style.width = `${e.event.shield}%`);
				break;
			case "updateResolution":
				updateHudPosition(e.event.Minimap);
				break;
			default:
				break;
		}
	});
});