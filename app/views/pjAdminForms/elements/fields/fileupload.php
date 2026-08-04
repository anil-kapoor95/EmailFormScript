<label class="field-label"><?php echo !empty($v['label']) ?  pjSanitize::html($v['label']) : __('lblFieldLabel', true, false);?></label>
<span class="inline-block">
	<input type="file" class="pj-form-field w320" />
</span>