const updateHudPosition = (Minimap) => {
	console.log("Updating HUD position", Minimap);
  document.querySelector(".info-container").style.width = Minimap.width * window.innerWidth + 2 + "px";
  document.querySelector(".top-container").style.width = Minimap.width * window.innerWidth + 2 + "px";

	const xCalc = Minimap.left_x * window.innerWidth + 14;
	const yCalc = Minimap.bottom_y * window.innerHeight;
  const yTop = Minimap.top_y * window.innerHeight;
  document.querySelector(".info-container").style.top = yCalc + "px";
  document.querySelector(".info-container").style.left = xCalc + "px";
  document.querySelector(".top-container").style.left = xCalc + "px";
  document.querySelector(".top-container").style.top = yTop + "px";
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
				document.getElementById("cash").textContent = `£${numberWithCommas(e.data.cash)}`;
				document.getElementById("bank").textContent = `£${numberWithCommas(e.data.bank)}`;
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

const numberWithCommas = (money) => money.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");