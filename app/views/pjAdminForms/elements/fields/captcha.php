<label class="field-label"><?php echo !empty($v['label']) ?  pjSanitize::html($v['label']) : __('lblFieldLabel', true, false);?></label>
<span class="inline-block">
	<input type="text" class="pj-form-field w80 float_left r3" /><img class="captcha" src="<?php echo PJ_IMG_PATH ?>backend/<?php echo $tpl['arr']['captcha_type'] == 'string' ? 'captcha' : 'math_captcha';?>.png" />
</span>