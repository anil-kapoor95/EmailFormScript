<label class="field-label">&nbsp;</label>
<span class="inline-block">
	<input type="button" value="<?php echo !empty($v['label']) ?  pjSanitize::html($v['label']) : __('btnSubmit', true, false); ?>" class="pj-button" />
</span>