field_messages:{
	<?php
	$message_arr = array();
	foreach($tpl['field_arr'] as $v)
	{
		$error_required = pjSanitize::clean($v['error_required']);
		
		
		if($v['type'] == 'fileupload')
		{
			$bracket = "";
			if($v['allow_mulitple'] == 'T')
			{
				$bracket = "[]";
			}
			$message_arr[] = '"pjCF_field_' . $v['id'] . $bracket . '"' . ': {required: "'.$error_required.'", extension: "'.pjSanitize::clean($v['error_extensions']).'", filesize: "'.pjSanitize::clean($v['error_maxsize']).'"}';
		}else if($v['type'] == 'dropdown' || $v['type'] == 'datepicker' || $v['type'] == 'textarea' || $v['type'] == 'radio'){
			$message_arr[] = 'pjCF_field_' . $v['id'] . ': {required: "'.$error_required.'"}';
		}else if($v['type'] == 'email'){
			$message_arr[] = 'pjCF_field_' . $v['id'] . ': {required: "'.$error_required.'", email: "'.pjSanitize::clean($v['error_email']).'"}';
		}else if($v['type'] == 'captcha'){
			$message_arr[] = 'captcha: {required: "'.$v['error_required'].'", remote: "'.pjSanitize::clean($v['error_incorrect']).'"}';
		}else if($v['type'] == 'checkbox'){
			$message_arr[] = '"pjCF_field_' . $v['id'] . '[]": {required: "'.$error_required.'"}';
		}else if($v['type'] == 'textbox'){
			$pj_validation = '';
			if($v['validation'] != 'none')
			{
				$pj_validation .= ', ';
				$pj_validation .= ($v['validation'] == 'numeric' ? 'number' : $v['validation']) . ': "'.pjSanitize::clean($v['error_validation']).'"}';
			}
			if($pj_validation == ''){
				$pj_validation = '}';
			}
			$message_arr[] = 'pjCF_field_' . $v['id'] . ': {required: "'.$error_required.'"' . $pj_validation;
		} 
	}
	echo implode(", ", $message_arr);
	?>
}