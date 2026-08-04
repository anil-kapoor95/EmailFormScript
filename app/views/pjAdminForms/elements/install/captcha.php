&lt;div class="row"&gt;
	&lt;div class="col-sm-6 col-xs-12"&gt;
		&lt;input type="text" name="captcha" maxlength="6" class="form-control pjCF-form-field required" /&gt;
	&lt;/div&gt;
	&lt;div class="col-sm-6 col-xs-12"&gt;
		&lt;img id="pjCF_captcha_img" src="<?php echo PJ_INSTALL_URL; ?>index.php?controller=pjFront&amp;action=pjActionCaptcha&amp;id=<?php echo $tpl['arr']['id']?>&amp;rand=<?php echo rand(1, 999999); ?>" alt="Captcha" style="cursor: pointer" /&gt;
	&lt;/div&gt;
&lt;/div&gt;