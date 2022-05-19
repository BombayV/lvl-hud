const updateHudPosition = (Minimap) => {
	console.log("Updating HUD position", Minimap);
	// document.querySelector(".info-container").style.opacity = "1";
	// document.querySelector(".top-container").style.opacity = "1";
}

window.addEventListener("load", () => {
	window.addEventListener("message", (e) => {
		switch (e.data.action) {
			case "updateHud":
				document.getElementById("health").style.width = `${e.data.health}%`;
				document.getElementById("shield").style.width = `${e.data.shield}%`;
				break;
			case "updateResolution":
				updateHudPosition(e.data.position);
				break;
			case "updateData":
				document.getElementById("cash").textContent = e.data.cash;
				document.getElementById("bank").textContent = e.data.bank
				break;
			case "updateDefaults":
				document.querySelector(".info-container").style.opacity = "1";
				document.querySelector(".top-container").style.opacity = "1";
				document.getElementById("top-info").textContent = e.data.topInfo;
				break;
			default:
				break;
		}
	});
});