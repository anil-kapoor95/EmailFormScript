<?php
$option_arr = explode("\n", str_replace("\r", "", $v['option_data']));
?>
<select name="pjCF_field_<?php echo $v['id'];?>" class="form-control pjCF-form-field" style="width: <?php echo $v['size'];?>% !important;">
	<option value="">----</option>
	<?php 
	foreach($option_arr as $val){
		$row_arr = explode("|@|", $val);
		if(count($row_arr) == 2){
			?><option value="<?php echo pjSanitize::clean($val);?>"><?php echo pjSanitize::clean($row_arr[0]);?></option><?php
		}else{
			?><option value="<?php echo pjSanitize::clean($val);?>"><?php echo pjSanitize::clean($val);?></option><?php
		}
	}
	?>
</select>