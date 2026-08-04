<div id="pjWrapperContactForm_<?php echo $_GET['fid'];?>">
	<div class="container-fluid pjCF-container">
		<?php
		if(!empty($tpl['arr']))
		{
			if ($tpl['arr']['status'] == 'T') {
				?>
				<img id="pjCF_loader_<?php echo $_GET['fid'];?>" src="<?php echo PJ_INSTALL_URL . PJ_IMG_PATH?>frontend/loader.gif" />
				<div id="pjCF_container_<?php echo $_GET['fid'];?>" style="display:none;" class="panel-body">
					<?php
					$horizontal_form = true;
					$label_class = 'col-sm-3 control-label';
					if($tpl['arr']['label_position'] == 'top')
					{
						$horizontal_form = false;
					}else{
						if($tpl['arr']['label_position'] == 'left')
						{
							$label_class = 'col-sm-3 control-label pjCfLeftAlign';
						}
					}
					?>
					<form action="<?php echo PJ_INSTALL_URL;?>index.php?controller=pjFront&action=pjActionSubmit" name="pjCF_form_<?php echo $_GET['fid'];?>" id="pjCF_form_<?php echo $_GET['fid'];?>" class="pjCF-form<?php echo $horizontal_form == true ? ' form-horizontal' : null; ?>" data-toggle="validator" role="form" method="post" enctype="multipart/form-data">
						<input type="hidden" name="id" value="<?php echo $_GET['fid'];?>" />
						<?php
						foreach($tpl['field_arr'] as $v)
						{
							if($v['type'] == 'heading')
							{
								?>
								<div class="form-group">
									<label class="col-sm-12 cf-heading cf-heading-<?php echo $v['heading_size'];?>"><?php echo pjSanitize::html($v['label']);?></label>
								</div>
								<?php
							}else if($v['type'] == 'button'){
								include PJ_VIEWS_PATH . 'pjFront/elements/button.php';
							}else{
								?>
								<div class="form-group">
									<label class="<?php echo $horizontal_form == true ? $label_class : null;?>"><?php echo pjSanitize::html($v['label']);?></label>
									<div class="<?php echo $horizontal_form == true ? 'col-sm-9 col-xs-12' : null;?><?php echo $v['type'] == 'fileupload' ? ' pjCfUploadField' : null;?>">
										<?php
										if($v['type'] == 'captcha')
										{
											?>
											<div id="pjCaptchaWrapper_<?php echo $_GET['fid'];?>"></div>
											<?php
										}else{
										   include PJ_VIEWS_PATH . 'pjFront/elements/'.$v['type'].'.php';
										}
										?>
										<div class="help-block with-errors"><ul class="list-unstyled"></ul></div>
									</div>
								</div>
								<?php
							}
						}
						?>
					</form>
					<div class="form-group">
						<div id="pjCF_message_container_<?php echo $_GET['fid'];?>" class="alert" role="alert" style="display:none;"></div>
					</div>
				</div>
				<?php
			}
		}else{
			__('front_form_not_found');
		} 
		?>
	</div>
</div>

<script type="text/javascript">
<?php
if(isset($tpl['arr']) && !empty($tpl['arr']))
{ 
	include PJ_VIEWS_PATH . 'pjFront/elements/frontjs.php';
} 
?>
</script>