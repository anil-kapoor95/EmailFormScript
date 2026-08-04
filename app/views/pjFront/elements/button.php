<?php
if($tpl['arr']['label_position'] == 'right' || $tpl['arr']['label_position'] == 'left')
{
	?>
	<div class="form-group">
		<div class="col-sm-offset-3 col-sm-6">
			<button style="pointer-events: all; cursor: pointer;" type="submit" class="btn btn-default btn-lg pjCF-button"><?php echo $v['label']; ?></button>
		</div>
	</div>
	<?php	
}else{
	?>
	<div class="form-group">
		<div class="col-sm-12">
			<button style="pointer-events: all; cursor: pointer;" type="submit" class="btn btn-default btn-lg pjCF-button"><?php echo $v['label']; ?></button>
		</div>
	</div>
	<?php
}
?>