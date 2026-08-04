<input type="hidden" name="field_id" value="<?php echo $tpl['field_arr']['id'];?>" />
<p>
	<label><?php __('lblLabel', false, true);?>:</label>
	<span class="block">
		<input name="label" class="pj-form-field" value="<?php echo $tpl['field_arr']['label'] != '' ? pjSanitize::clean($tpl['field_arr']['label']) : null; ?>"/>
	</span>
</p>
<p>
	<label><?php __('lblRequiredErrorMessage', false, true);?>:</label>
	<span class="block">
		<input name="error_required" class="pj-form-field" value="<?php echo $tpl['field_arr']['error_required'] != '' ? pjSanitize::clean($tpl['field_arr']['error_required']) : null; ?>"/>
	</span>
</p>
<p>
	<label><?php __('lblCaptchaIncorrectMessage', false, true);?>:</label>
	<span class="block">
		<input name="error_incorrect" class="pj-form-field" value="<?php echo $tpl['field_arr']['error_incorrect'] != '' ? pjSanitize::clean($tpl['field_arr']['error_incorrect']) : null; ?>"/>
	</span>
</p>
<p>
	<label><?php __('lblSize', false, true);?>(%):</label>
	<span class="block">
		<input name="size" class="pj-form-field" value="<?php echo $tpl['field_arr']['size'] != '' ? $tpl['field_arr']['size'] : null; ?>"/>
	</span>
</p>