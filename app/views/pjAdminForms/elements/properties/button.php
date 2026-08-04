<input type="hidden" name="field_id" value="<?php echo $tpl['field_arr']['id'];?>" />
<p>
	<label><?php __('lblLabel', false, true);?>:</label>
	<span class="block">
		<input name="label" class="pj-form-field" value="<?php echo $tpl['field_arr']['label'] != '' ? pjSanitize::clean($tpl['field_arr']['label']) : null; ?>"/>
	</span>
</p>