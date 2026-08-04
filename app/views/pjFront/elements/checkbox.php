<?php
$option_arr = __('default_options', true, false);
if($v['option_data'] != '')
{
	$option_arr = explode("\n", str_replace("\r", "", $v['option_data']));
} 
$index = 1;
foreach($option_arr as $val)
{
	?>
	<div class="checkbox">
		<label>
			<input type="checkbox" name="pjCF_field_<?php echo $v['id'];?>[]" id="pjCF_checkbox_<?php echo $index;?>" value="<?php echo pjSanitize::clean($val); ?>" class="cfR3<?php echo $v['required'] == 'T' ? ' required' : null;?>"/>
			<?php echo pjSanitize::clean($val);?>
		</label>
	</div>
	<?php
	$index++;
}
?>