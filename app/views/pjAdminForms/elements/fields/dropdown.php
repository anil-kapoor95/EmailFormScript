<label class="field-label"><?php echo !empty($v['label']) ?  pjSanitize::html($v['label']) : __('lblFieldLabel', true, false);?></label>
<span class="inline-block">
	<?php
	$option_arr = explode("\n", str_replace("\r", "", $v['option_data']));
	?>
	<select class="pj-form-field w320">
		<?php 
		foreach($option_arr as $val){
			$row_arr = explode("|@|", $val);
			if(count($row_arr) == 2){
				?><option value="<?php echo $val;?>"><?php echo $row_arr[0];?></option><?php
			}else{
				?><option value="<?php echo $val;?>"><?php echo $val;?></option><?php
			}
		}
		?>
	</select>
</span>