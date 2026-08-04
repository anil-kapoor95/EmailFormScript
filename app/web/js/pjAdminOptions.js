var jQuery_1_8_2 = jQuery_1_8_2 || $.noConflict();
(function ($, undefined) {
	$(function () {
		"use strict";
		var tipsy = ($.fn.tipsy !== undefined),
			tabs = ($.fn.tabs !== undefined),
			$tabs = $("#tabs");

		if ($tabs.length > 0 && tabs) {
			$tabs.tabs();
		}
		if (tipsy) {
			$(".center-langbar-tip").tipsy({
				offset: 1,
				opacity: 1,
				html: true,
				className: "tipsy-listing-center"
			});
		}
		$(".field-int").spinner({
			min: 0
		});

		// Base URL of the current admin script (index.php).
		var baseUrl = window.location.pathname;

		// Max time (ms) to wait for an AJAX test before giving up, so the UI
		// never stays stuck on "please wait" if the SMTP server does not answer.
		var AJAX_TIMEOUT = 25000;

		var EMAIL_RE = /^[^@\s]+@[^@\s]+\.[^@\s]+$/;

		// Dynamic, localized UI strings (populated by the view). Fallbacks keep
		// the screen readable if the labels have not been provided.
		var L = window.pjEmailLabels || {};
		function lbl(key, def) {
			return (L && typeof L[key] === 'string' && L[key] !== '') ? L[key] : def;
		}

		// Return the part after "::" for enum select values (e.g. "mail|smtp::smtp" -> "smtp").
		function enumVal(v) {
			if (typeof v !== 'string') {
				return '';
			}
			var i = v.indexOf('::');
			return i >= 0 ? v.substring(i + 2) : v;
		}

		// Collect the current values of the Email Settings form.
		function collectEmailSettings() {
			return {
				send_email:  enumVal($('select[name="value-enum-o_send_email"]').val()),
				smtp_host:   $.trim($('input[name="value-string-o_smtp_host"]').val() || ''),
				smtp_port:   $.trim($('input[name="value-int-o_smtp_port"]').val() || ''),
				smtp_secure: enumVal($('select[name="value-enum-o_smtp_secure"]').val()),
				smtp_auth:   enumVal($('select[name="value-enum-o_smtp_auth"]').val()),
				smtp_user:   $.trim($('input[name="value-string-o_smtp_user"]').val() || ''),
				smtp_pass:   $('input[name="value-string-o_smtp_pass"]').val() || '',
				from_email:  $.trim($('input[name="value-string-o_from_email"]').val() || ''),
				from_name:   $.trim($('input[name="value-string-o_from_name"]').val() || '')
			};
		}

		function paint($box, type, text) {
			if (!$box || $box.length === 0) {
				return;
			}
			var bg, border, color;
			if (type === 'success') {
				bg = '#e6f4ea'; border = '#a3d9b1'; color = '#1e7e34';
			} else if (type === 'loading') {
				bg = '#eef3fb'; border = '#c2d4f0'; color = '#274b8c';
			} else {
				bg = '#fdecea'; border = '#f5c2c0'; color = '#a11a12';
			}
			$box.css({
				'display': 'block',
				'background-color': bg,
				'border': '1px solid ' + border,
				'color': color
			}).html(text);
		}

		function showTestResult(type, text) {
			paint($('#emailTestResult'), type, text);
		}

		function postTest(action, data, $box, $btn, loadingText, failText) {
			paint($box, 'loading', loadingText);
			if ($btn) { $btn.prop('disabled', true); }
			return $.ajax({
				type: 'POST',
				url: baseUrl + '?controller=pjAdminOptions&action=' + action,
				data: data,
				dataType: 'json',
				timeout: AJAX_TIMEOUT
			}).done(function (resp) {
				if (resp && resp.status === 'OK') {
					paint($box, 'success', resp.text);
				} else {
					paint($box, 'error', (resp && resp.text) ? resp.text : failText);
				}
			}).fail(function (xhr, textStatus) {
				var msg = (textStatus === 'timeout')
					? failText
					: lbl('unexpected', 'An unexpected error occurred.');
				paint($box, 'error', msg);
			}).always(function () {
				if ($btn) { $btn.prop('disabled', false); }
			});
		}

		var $content = $("#content").length ? $("#content") : $(document);

		// ---- Send test email dialog (jQuery UI dialog - the script's own component) ----
		var dialog = ($.fn.dialog !== undefined),
			$emailTestDialog = $("#emailTestDialog");

		function doSendTestEmail() {
			var email = $.trim($('#emailTestModalEmail').val() || '');
			var $msg = $('#emailTestModalMsg');
			if (!email) {
				paint($msg, 'error', lbl('enterEmail', 'Please enter an email address.'));
				return;
			}
			if (!EMAIL_RE.test(email)) {
				paint($msg, 'error', lbl('validEmail', 'Please enter a valid email address.'));
				return;
			}
			var data = collectEmailSettings();
			data.email = email;
			postTest('pjActionAjaxSend', data, $msg, null,
				lbl('sending', 'Sending test email, please wait...'),
				lbl('sendFail', 'The test email could not be sent.'));
		}

		if ($emailTestDialog.length > 0 && dialog) {
			$emailTestDialog.dialog({
				modal: true,
				autoOpen: false,
				resizable: false,
				draggable: false,
				width: 480,
				buttons: [
					{ text: lbl('cancel', 'Cancel'), click: function () { $(this).dialog('close'); } },
					{ text: lbl('sendEmail', 'Send Email'), click: function () { doSendTestEmail(); } }
				]
			});
		}

		$content
			.on("focusin", ".textarea_install", function (e) {
				$(this).select();
			})
			.on("change", "select[name='value-enum-o_send_email']", function (e) {
				switch ($("option:selected", this).val()) {
				case 'mail|smtp::mail':
					$(".boxSmtp").hide();
					break;
				case 'mail|smtp::smtp':
					$(".boxSmtp").show();
					break;
				}
			})
			.on("click", "#btnTestConnection", function (e) {
				e.preventDefault();
				var data = collectEmailSettings();
				if (!data.smtp_host || !data.smtp_port) {
					showTestResult('error', lbl('enterHost', 'Please enter the SMTP host and port first.'));
					return;
				}
				postTest('pjActionAjaxSmtp', {
					smtp_host:   data.smtp_host,
					smtp_port:   data.smtp_port,
					smtp_secure: data.smtp_secure,
					smtp_auth:   data.smtp_auth,
					smtp_user:   data.smtp_user,
					smtp_pass:   data.smtp_pass
				}, $('#emailTestResult'), $(this),
				lbl('testing', 'Testing SMTP connection, please wait...'),
				lbl('connFail', 'Connection failed. Please check your SMTP settings.'));
			})
			.on("click", "#btnSendTestEmail", function (e) {
				e.preventDefault();
				if (!($emailTestDialog.length > 0 && dialog)) {
					return;
				}
				var data = collectEmailSettings();
				$('#emailTestModalMsg').hide().empty();
				$('#emailTestModalEmail').val(data.from_email || '');
				$emailTestDialog.dialog('open');
				$('#emailTestModalEmail').focus();
			});
	});
})(jQuery_1_8_2);
