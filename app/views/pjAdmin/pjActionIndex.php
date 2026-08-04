<?php
if (isset($tpl['status']))
{
	$status = __('status', true);
	switch ($tpl['status'])
	{
		case 2:
			pjUtil::printNotice(NULL, $status[2]);
			break;
	}
}else{
	?>
	<div class="dashboard_header">
		<div class="item">
			<div class="stat submissions">
				<div class="info">
					
				</div>
			</div>
		</div>
		<div class="item">
			<div class="stat forms">
				<div class="info">
					
				</div>
			</div>
		</div>
		<div class="item">
			<div class="stat users">
				<div class="info">
					
				</div>
			</div>
		</div>
	</div>
	
	<div class="dashboard_box">
		<div class="dashboard_top">
			<div class="dashboard_column_top"></div>
			<div class="dashboard_column_top"></div>
			<div class="dashboard_column_top"></div>
		</div>
		
		<div class="dashboard_middle">
			<div class="dashboard_column">
				
			</div>
			<div class="dashboard_column">
				
			</div>
			<div class="dashboard_column">
				
			</div>
		</div>
		<div class="dashboard_bottom"></div>
	</div>
	
	<div class="clear_left t20 overflow">
		<div class="float_left black t30 t20"><span class="gray"><?php echo ucfirst(__('lblDashLastLogin', true)); ?>:</span> <?php echo pjUtil::formatDate(date('Y-m-d', strtotime($_SESSION[$controller->defaultUser]['last_login'])), 'Y-m-d', $tpl['option_arr']['o_date_format']) . ' ' . pjUtil::formatTime(date('H:i:s', strtotime($_SESSION[$controller->defaultUser]['last_login'])), 'H:i:s', $tpl['option_arr']['o_time_format']); ?></div>
		<div class="float_right overflow">
		<?php
		list($hour, $day, $other) = explode("_", date("H:i_l_F d, Y"));
		$days = __('days', true, false);
		?>
			<div class="dashboard_date">
				<abbr><?php echo $days[date('w')]; ?></abbr>
				<?php echo pjUtil::formatDate(date('Y-m-d'), 'Y-m-d', $tpl['option_arr']['o_date_format']) . ' ' . pjUtil::formatTime(date('H:i:s'), 'H:i:s', $tpl['option_arr']['o_time_format']); ?>
			</div>
			<div class="dashboard_hour"><?php echo $hour; ?></div>
		</div>
	</div>
	<?php
}
?>