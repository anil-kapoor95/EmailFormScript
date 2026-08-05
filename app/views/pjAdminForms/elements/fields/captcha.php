<label class="field-label"><?php echo !empty($v['label']) ?  pjSanitize::html($v['label']) : __('lblFieldLabel', true, false);?></label>
<span class="inline-block">
<?php if (isset($tpl['option_arr']['o_captcha_provider']) && $tpl['option_arr']['o_captcha_provider'] == 'recaptcha') { ?>
	<span style="display:inline-block;border:1px solid #d3d3d3;background:#f9f9f9;border-radius:3px;padding:10px 12px;line-height:1;box-shadow:0 0 4px 1px rgba(0,0,0,0.08);">
		<input type="checkbox" disabled="disabled" style="width:24px;height:24px;vertical-align:middle;margin:0 8px 0 0;" />
		<span style="vertical-align:middle;font-size:14px;color:#000;"><?php __('lblRecaptchaMock'); ?></span>
	</span>
<?php } else { ?>
	<input type="text" class="pj-form-field w80 float_left r3" /><img class="captcha" src="<?php echo PJ_IMG_PATH ?>backend/<?php echo $tpl['arr']['captcha_type'] == 'string' ? 'captcha' : 'math_captcha';?>.png" />
<?php } ?>
</span>