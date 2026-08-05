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
		
		$("#content").on("focusin", ".textarea_install", function (e) {
			$(this).select();
		}).on("change", "select[name='value-enum-o_send_email']", function (e) {
			switch ($("option:selected", this).val()) {
			case 'mail|smtp::mail':
				$(".boxSmtp").hide();
				break;
			case 'mail|smtp::smtp':
				$(".boxSmtp").show();
				break;
			}
		}).on("change", "select[name='value-enum-o_captcha_provider']", function (e) {
			switch ($("option:selected", this).val()) {
			case 'phpjabbers|recaptcha::phpjabbers':
				$(".boxRecaptcha").hide();
				break;
			case 'phpjabbers|recaptcha::recaptcha':
				$(".boxRecaptcha").show();
				break;
			}
		});
	});
})(jQuery_1_8_2);