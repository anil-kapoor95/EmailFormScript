<label class="field-label"><?php echo !empty($v['label']) ?  pjSanitize::html($v['label']) : __('lblFieldLabel', true, false);?></label>
<span class="inline-block">
	<span class="pj-form-field-custom pj-form-field-custom-after">
		<input type="text" class="pj-form-field pointer w80 datepick" readonly="readonly" />
		<span class="pj-form-field-after"><abbr class="pj-form-field-icon-date"></abbr></span>
	</span>
</span>