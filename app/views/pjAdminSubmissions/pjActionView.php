<?php
ob_start(); 
?>
<div id="pjCF_container_<?php echo $tpl['arr']['id'];?>" class="pjCF-container pjCF-form">
	<?php
	$label_position = ' cfB5';
	if($tpl['arr']['label_position'] == 'right')
	{
		$label_position = ' cfFloatLeft cfAlignRight';
	}else if($tpl['arr']['label_position'] == 'left'){
		$label_position = ' cfFloatLeft';
	}
	?>
	<p>
		<label class="cf-title<?php echo $label_position;?>"><?php __('lblDateSplashTime');?>:</label>
		<span class="cfBlock cfOverflow cfT6"><?php echo date($tpl['option_arr']['o_date_format'], strtotime($tpl['submission_arr']['submitted_date'])). ', ' . date($tpl['option_arr']['o_time_format'], strtotime($tpl['submission_arr']['submitted_date']));?></span>
	</p>
	<p>
		<label class="cf-title<?php echo $label_position;?>"><?php __('lblIp');?>:</label>
		<span class="cfBlock cfOverflow cfT6"><?php echo $tpl['submission_arr']['ip'];?></span>
	</p>
	<br/>
	<?php
	foreach($tpl['field_arr'] as $v)
	{
		if($v['type'] == 'heading')
		{
			?>
			<p>
				<label class="cf-heading cf-heading-<?php echo $v['heading_size'];?>"><?php echo pjSanitize::html($v['label']);?></label>
			</p>
			<?php
		}else if($v['type'] != 'button' && $v['type'] != 'captcha'){
			?>
			<p>
				<label class="cf-title<?php echo $label_position;?>"><?php echo pjSanitize::html($v['label']);?>:</label>
				<span class="cfBlock cfOverflow cfT6">
					<?php
					if($v['type'] == 'checkbox' || $v['type'] == 'fileupload'){
						if($v['type'] == 'fileupload'){
							if(!empty($tpl['file_arr'][$v['field_id']])){
							    $file_name_arr = array();
								foreach($tpl['file_arr'][$v['field_id']] as $f){
								    $file_name_arr[] = '<a href="'.PJ_INSTALL_URL . 'file.php?id='.$f['id'].'&amp;hash=' .$f['hash'].'">'.pjSanitize::clean($f['file_name']).'</a>';
								}
								echo join(" | ", $file_name_arr);
							}	
						}else{
							echo str_replace("|", "<br/>", pjSanitize::html($v['value']));
						}
					}else{
						echo pjSanitize::html($v['value']);
					}
					?>
				</span>
			</p>
			<?php
		}
	} 
	?>
</div>
<style>
<!--
.pjCF-form p{
	display: block;
	line-height: 24px;
}
-->
</style>
<?php
$ob_view = ob_get_contents();
ob_end_clean();
$form_title = __('lblForm', true) . ': ' . pjSanitize::html($tpl['arr']['form_title']); 
pjAppController::jsonResponse(compact('ob_view', 'form_title'));
?>