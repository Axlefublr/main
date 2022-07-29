// ==UserScript==
// @name         YouTube switch channel
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  try to take over the world!
// @author       You
// @match        https://www.youtube.com/*
// @icon         https://www.google.com/s2/favicons?sz=64&domain=tampermonkey.net
// @grant        none
// ==/UserScript==

document.onkeyup = function (key) {
	if (key.which == 77) {
		let accountPfp = document.querySelector(
			"#contents > ytd-account-item-renderer:nth-child(3) > tp-yt-paper-icon-item > tp-yt-paper-item-body > yt-formatted-string:nth-child(3)"
		);
		accountPfp.click()
	}
}