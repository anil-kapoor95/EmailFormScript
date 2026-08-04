<?php
$months = __('months', true);
$short_months = __('short_months', true);
ksort($months);
ksort($short_months);
$days = __('days', true);
$short_days = __('short_days', true); 
?>
&lt;div class="input-group" style="width: <?php echo $v['size']; ?>% !important;"&gt;
	&lt;input type="text" id="pjCF_field_<?php echo $v['id'];?>" name="pjCF_field_<?php echo $v['id'];?>" class="form-control pjCF-form-field cfW120 cfPointer cfDatePicker" data-months="<?php echo join(',', $months);?>" data-shortmonths="<?php echo join(',', $short_months);?>" data-day="<?php echo join(',', $days);?>" data-daymin="<?php echo join(',', $short_days);?>"/&gt;
	&lt;a href="#" class="cfFormFieldIconAfter input-group-addon calendar-trigger"&gt;&lt;span class="glyphicon glyphicon-calendar" aria-hidden="true"&gt;&lt;/span&gt;&lt;/a&gt;
&lt;/div&gt;