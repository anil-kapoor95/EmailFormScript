field_rules:{
	<?php
	$rule_arr = array();
	foreach($tpl['field_arr'] as $v)
	{
		if($v['type'] == 'fileupload')
		{
			$bracket = "";
			if($v['allow_mulitple'] == 'T')
			{
				$bracket = "[]";
			}
			$true_false = $v['required'] == 'T' ? 'true' : 'false';
			$rule_arr[] = '"pjCF_field_' . $v['id'] . $bracket . '"' . ': {required: '.$true_false.', extension: "'.$v['extensions'].'", filesize: '.($v['max_file_size'] * 1024 * 1024).'}';
		}else if($v['type'] == 'dropdown' || $v['type'] == 'datepicker' || $v['type'] == 'textarea'){
			$true_false = $v['required'] == 'T' ? 'true' : 'false';
			$rule_arr[] = 'pjCF_field_' . $v['id'] . ': {required: '.$true_false.'}';
		}else if($v['type'] == 'email'){
			$true_false = $v['required'] == 'T' ? 'true' : 'false';
			$rule_arr[] = 'pjCF_field_' . $v['id'] . ': {required: '.$true_false.', email: true}';
		}else if($v['type'] == 'textbox'){
			$true_false = $v['required'] == 'T' ? 'true' : 'false';
			$pj_validation = '';
			if($v['validation'] != 'none')
			{
				$pj_validation .= ', ';
				$pj_validation .= ($v['validation'] == 'numeric' ? 'number' : $v['validation']) . ': true}';
			}
			if($pj_validation == ''){
				$pj_validation = '}';
			}
			$rule_arr[] = 'pjCF_field_' . $v['id'] . ': {required: '.$true_false . $pj_validation;
		} 
	}
	echo implode(", ", $rule_arr);
	?>
}