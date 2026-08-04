<?php
$option_arr = explode("\n", str_replace("\r", "", $v['option_data']));
?>
&lt;select name="pjCF_field_<?php echo $v['id'];?>" class="form-control pjCF-form-field"&gt;
	&lt;option value=""&gt;----&lt;/option&gt;
	<?php 
	foreach($option_arr as $val){
		$row_arr = explode("|@|", $val);
		if(count($row_arr) == 2){
			?>&lt;option value="<?php echo pjSanitize::clean($val);?>"&gt;<?php echo pjSanitize::clean($row_arr[0]);?>&lt;/option&gt;<?php
		}else{
			?>&lt;option value="<?php echo pjSanitize::clean($val);?>"&gt;<?php echo pjSanitize::clean($val);?>&lt;/option&gt;<?php
		}
	}
	?>
&lt;/select&gt;