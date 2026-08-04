<label class="field-label"><?php echo !empty($v['label']) ?  pjSanitize::html($v['label']) : __('lblFieldLabel', true, false);?></label>
<span class="inline-block">
	<input type="text" value="<?php echo $v['default_value'] != '' ? $v['default_value']: null; ?>" class="pj-form-field w320" placeholder="<?php echo $v['hint'] != '' ? $v['hint']: null; ?>" />
</span>