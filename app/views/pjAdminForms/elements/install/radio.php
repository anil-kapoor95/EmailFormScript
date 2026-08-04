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
	&lt;div class="radio"&gt;
		&lt;label&gt;
			&lt;input type="radio" name="pjCF_field_<?php echo $v['id'];?>" id="pjCF_radio_<?php echo $index;?>" value="<?php echo pjSanitize::clean($val); ?>"  class="cfR3<?php echo $v['required'] == 'T' ? ' required' : null;?>"/&gt;
			<?php echo pjSanitize::clean($val);?>
		&lt;/label&gt;
	&lt;/div&gt;
	<?php
	$index++;
}
?>