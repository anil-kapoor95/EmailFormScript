var jQuery_1_8_2 = jQuery_1_8_2 || $.noConflict();
(function ($, undefined) {
	"use strict";

	/* ---- CSRF protection (admin) -------------------------------------- */
	function pjGetCookie(name) {
		var m = document.cookie.match(new RegExp('(?:^|; )' + name.replace(/([.$?*|{}()\[\]\\\/\+^])/g, '\\$1') + '=([^;]*)'));
		return m ? decodeURIComponent(m[1]) : '';
	}
	var pjToken = pjGetCookie('pj_csrf_token');
	if (pjToken) {
		// 1) Send the token as a request header on every same-origin admin AJAX
		//    call (covers datagrid delete/bulk/sort, delete-field, set-active, etc.).
		//    The token is never placed in the URL.
		$.ajaxPrefilter(function (options) {
			if (options.crossDomain) { return; }
			if ((options.url || '').indexOf('controller=pjFront') > -1) { return; }
			options.headers = options.headers || {};
			options.headers['X-CSRF-Token'] = pjToken;
			// For POST requests also add the token to the body as csrf_token, so it
			// appears in the request payload for create/delete/update/etc.
			var method = (options.type || options.method || 'GET').toUpperCase();
			if (method === 'POST') {
				var pair = 'csrf_token=' + encodeURIComponent(pjToken);
				if (options.data === undefined || options.data === null || options.data === '') {
					options.data = pair;
				} else if (typeof options.data === 'string') {
					if (options.data.indexOf('csrf_token=') === -1) { options.data += '&' + pair; }
				} else if (window.FormData && options.data instanceof FormData) {
					options.data.append('csrf_token', pjToken);
				} else if (typeof options.data === 'object') {
					options.data.csrf_token = pjToken;
				}
			}
		});
		// 2) Inject a hidden csrf_token field into admin POST forms on submit.
		//    GET forms (e.g. search) are skipped so the token never lands in the URL.
		$(document).on('submit', 'form', function () {
			var $f = $(this);
			if (($f.attr('method') || 'get').toLowerCase() !== 'post') { return; }
			if (($f.attr('action') || '').indexOf('controller=pjFront') > -1) { return; }
			if ($f.find('input[name="csrf_token"]').length === 0) {
				$('<input>', { type: 'hidden', name: 'csrf_token', value: pjToken }).appendTo($f);
			}
		});
		// 3) State-changing GET-navigation links (clone / duplicate) are submitted
		//    as a POST with the token in the body, so the token is not put in the URL.
		$(document).on('click', 'a[href]', function (e) {
			var $a = $(this);
			var href = $a.attr('href') || '';
			if (/action=pjAction(Clone|Duplicate)/i.test(href) && href.indexOf('controller=pjFront') === -1) {
				if (e && e.preventDefault) { e.preventDefault(); }
				var $form = $('<form>', { method: 'POST', action: href }).appendTo('body');
				$('<input>', { type: 'hidden', name: 'csrf_token', value: pjToken }).appendTo($form);
				$form.get(0).submit();
				$form.remove();
			}
		});
	}
	/* ------------------------------------------------------------------- */

	$(function () {
		$(".pj-table tbody tr").hover(
			function () {
				$(this).addClass("pj-table-row-hover");
			},
			function () {
				$(this).removeClass("pj-table-row-hover");
			}
		);
		$(".pj-button").hover(
			function () {
				$(this).addClass("pj-button-hover");
			},
			function () {
				$(this).removeClass("pj-button-hover");
			}
		);
		$(".pj-checkbox").hover(
				function () {
					$(this).addClass("pj-checkbox-hover");
				},
				function () {
					$(this).removeClass("pj-checkbox-hover");
				}
			);
		$("#content").on("click", ".notice-close", function (e) {
			if (e && e.preventDefault) {
				e.preventDefault();
			}
			$(this).closest(".notice-box").fadeOut();
			return false;
		});
	});
})(jQuery_1_8_2);