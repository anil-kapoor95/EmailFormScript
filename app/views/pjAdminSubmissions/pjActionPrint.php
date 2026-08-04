<!DOCTYPE html>
<html>
	<head>
		<title><?php echo $tpl['arr']['form_title'];?></title>
	<head>
	<body>
		<div id="pjCF_container_<?php echo $tpl['arr']['id'];?>" class="pjCF-container pjCF-form">
			<?php
			$label_position = ' cfB5';
			if($tpl['arr']['label_position'] == 'right')
			{
				$label_position = ' cfFloatLeft cfAlignRight';
			}else if($tpl['arr']['label_position'] == 'left'){
				$label_position = ' cfFloatLeft';
			}
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
										foreach($tpl['file_arr'][$v['field_id']] as $f){
											?><a class="pjCF-file-uploaded" href="<?php echo PJ_INSTALL_URL . 'file.php?id='.$f['id'].'&amp;hash=' .$f['hash'];?>"><?php echo pjSanitize::clean($f['file_name'])?></a><?php
										}
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
		<link href="<?php echo PJ_INSTALL_URL; ?>/index.php?controller=pjFront&action=pjActionLoadCss&fid=<?php echo $tpl['arr']['id'];?>" type="text/css" rel="stylesheet" />
	</body>
</html>