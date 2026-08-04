var pjQ = pjQ || {},
	ContactForm_<?php echo $_GET['fid']; ?>;
(function () {
	"use strict";
	var isSafari = /Safari/.test(navigator.userAgent) && /Apple Computer/.test(navigator.vendor);
	var loadRemote = function(url, type, callback) {
		var _element, _type, _attr, scr, s, element;
		
		switch (type) {
		case 'css':
			_element = "link";
			_type = "text/css";
			_attr = "href";
			break;
		case 'js':
			_element = "script";
			_type = "text/javascript";
			_attr = "src";
			break;
		}
		
		scr = document.getElementsByTagName(_element);
		s = scr[scr.length - 1];
		element = document.createElement(_element);
		element.type = _type;
		if (type == "css") {
			element.rel = "stylesheet";
		}
		if (element.readyState) {
			element.onreadystatechange = function () {
				if (element.readyState == "loaded" || element.readyState == "complete") {
					element.onreadystatechange = null;
					callback();
				}
			};
		} else {
			element.onload = function () {
				callback();
			};
		}
		element[_attr] = url;
		s.parentNode.insertBefore(element, s.nextSibling);
	},
	getSessionId = function () {
		return sessionStorage.getItem("session_id") == null ? "" : sessionStorage.getItem("session_id");
	},
	createSessionId = function () {
		if(getSessionId()=="") {
			sessionStorage.setItem("session_id", "<?php echo session_id(); ?>");
		}
	},
	loadScript = function (url, callback) {
		loadRemote(url, "js", callback);
	},
	loadCss = function (url, callback) {
		loadRemote(url, "css", callback);
	};
	<?php $error_msg = str_replace(array('"', "'"), array('\"', "\'"), __('front_err', true, false));?>
	<?php $post_max_size = str_replace("{SIZE}", ini_get('post_max_size'), __('front_post_content_size', true));?>
	<?php $upload_max_size = str_replace("{SIZE}", ini_get('upload_max_filesize'), __('front_upload_max_size', true));?>
	var CFObj = {
		server: "<?php echo PJ_INSTALL_URL; ?>",
		folder: "<?php echo PJ_INSTALL_URL; ?>",
		fid: <?php echo $_GET['fid']; ?>,

		form: "pjCF_form_<?php echo $_GET['fid'];?>",
		week_start: <?php echo $tpl['option_arr']['o_week_start']; ?>,
		jq_date_format: "<?php echo pjUtil::jqDateFormat($tpl['arr']['date_format']);?>",
		date_format: "<?php echo $tpl['arr']['date_format']; ?>",
		confirm_option: "<?php echo $tpl['arr']['confirm_options']; ?>",
		thankyou_page: "<?php echo $tpl['arr']['thankyou_page']; ?>",
		confirm_message: "<?php echo pjSanitize::clean($tpl['arr']['confirm_message']); ?>",
		banned_words: "<?php echo !empty($tpl['arr']['block_words']) ? trim(str_replace( array("\r\n"), "|", $tpl['arr']['block_words'])) : ''; ?>",
		error_message: <?php echo pjAppController::jsonEncode($error_msg); ?>,
		error_post_max_size: "<?php echo pjSanitize::clean($post_max_size); ?>",
		error_upload_max_size: "<?php echo pjSanitize::clean($upload_max_size); ?>",
		is_reject: <?php echo $tpl['arr']['reject_links'] == 'T' ? 'true' : 'false'; ?>,

		<?php include PJ_VIEWS_PATH . 'pjFront/elements/rules.php';  ?>,
		<?php include PJ_VIEWS_PATH . 'pjFront/elements/messages.php';  ?>
	};
	<?php
	$dm = new pjDependencyManager(PJ_INSTALL_PATH, PJ_THIRD_PARTY_PATH);
	$dm->load(PJ_CONFIG_PATH . 'dependencies.php')->resolve();
	?>
	loadScript("<?php echo PJ_INSTALL_URL . $dm->getPath('storage_polyfill'); ?>storagePolyfill.min.js", function () {
		if (isSafari) {
			createSessionId();
			CFObj.session_id = getSessionId();
		}else{
			CFObj.session_id = "";
		}
    	loadScript("<?php echo PJ_INSTALL_URL . $dm->getPath('pj_jquery'); ?>pjQuery.min.js", function () {
    		loadScript("<?php echo PJ_INSTALL_URL . $dm->getPath('pj_validate'); ?>pjQuery.validate.min.js", function () {
    			loadScript("<?php echo PJ_INSTALL_URL . $dm->getPath('pj_validate'); ?>pjQuery.additional-methods.min.js", function () {
    				loadScript("<?php echo PJ_INSTALL_URL . $dm->getPath('pj_bootstrap'); ?>pjQuery.bootstrap.min.js", function () {
    					loadScript("<?php echo PJ_INSTALL_URL . $dm->getPath('pj_jquery_ui'); ?>js/pjQuery-ui.custom.min.js", function () {
    						loadScript("<?php echo PJ_INSTALL_URL . $dm->getPath('pj_form'); ?>pjQuery.form.min.js", function () {
    							loadScript("<?php echo PJ_INSTALL_URL . PJ_JS_PATH; ?>pjLoad.js", function () {
    								ContactForm_<?php echo $_GET['fid']; ?> = new ContactForm(CFObj);
    							});
    						});
    					});
    				});
    			});
    		});
    	});
    });
})();