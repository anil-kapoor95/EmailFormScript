<textarea class="pj-form-field textarea_install" style="overflow: auto; width: 726px; height:300px;">&lt;div id="pjWrapperContactForm_<?php echo $_GET['id'];?>"&gt;
	&lt;div class="container-fluid pjCF-container"&gt;
		&lt;img id="pjCF_loader_<?php echo $_GET['id'];?>" src="<?php echo PJ_INSTALL_URL . PJ_IMG_PATH?>frontend/loader.gif" /&gt;
		&lt;div id="pjCF_container_<?php echo $_GET['id'];?>" style="display:none;" class="panel-body"&gt;
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
			&lt;form action="<?php echo PJ_INSTALL_URL;?>index.php?controller=pjFront&action=pjActionSubmit" name="pjCF_form_<?php echo $_GET['id'];?>" id="pjCF_form_<?php echo $_GET['id'];?>" class="pjCF-form<?php echo $horizontal_form == true ? ' form-horizontal' : null; ?>" data-toggle="validator" role="form" method="post" enctype="multipart/form-data"&gt;
				&lt;input type="hidden" name="id" value="<?php echo $_GET['id'];?>" /&gt;
				<?php
				foreach($tpl['field_arr'] as $v)
				{
					if($v['type'] == 'heading')
					{
						?>
						&lt;div class="form-group"&gt;
							&lt;label class="col-sm-12 cf-heading cf-heading-<?php echo $v['heading_size'];?>"&gt;<?php echo pjSanitize::html($v['label']);?>&lt;/label&gt;
						&lt;/div&gt;
						<?php
					}else if($v['type'] == 'button'){
						include PJ_VIEWS_PATH . 'pjAdminForms/elements/install/button.php';
					}else{
						?>
						&lt;div class="form-group"&gt;
							&lt;label class="<?php echo $horizontal_form == true ? $label_class : null;?>"&gt;<?php echo pjSanitize::html($v['label']);?>&lt;/label&gt;
							&lt;div class="<?php echo $horizontal_form == true ? 'col-sm-9 col-xs-12' : null;?><?php echo $v['type'] == 'fileupload' ? ' pjCfUploadField' : null;?>"&gt;
								<?php
								if($v['type'] == 'captcha')
								{
								    ?>&lt;div id="pjCaptchaWrapper_<?php echo $_GET['id'];?>"&gt;&lt;/div&gt;<?php
								}else{
								    include PJ_VIEWS_PATH . 'pjAdminForms/elements/install/'.$v['type'].'.php';
								}
								?>
								&lt;div class="help-block with-errors"&gt;&lt;ul class="list-unstyled"&gt;&lt;/ul&gt;&lt;/div&gt;
							&lt;/div&gt;
						&lt;/div&gt;
						<?php
					}
				} 
				?>
			&lt;/form&gt;
			&lt;div class="form-group"&gt;
				&lt;div id="pjCF_message_container_<?php echo $_GET['id'];?>" class="alert" role="alert"&gt;&lt;/div&gt;
			&lt;/div&gt;
		&lt;/div&gt;
	&lt;/div&gt;
&lt;link href="<?php echo PJ_INSTALL_URL.PJ_FRAMEWORK_LIBS_PATH; ?>pj/css/pj.bootstrap.min.css" type="text/css" rel="stylesheet" /&gt;
&lt;link href="<?php echo PJ_INSTALL_URL; ?>index.php?controller=pjFront&action=pjActionLoadCss&fid=<?php echo $_GET['id'];?>" type="text/css" rel="stylesheet" /&gt;
&lt;script type="text/javascript" src="<?php echo PJ_INSTALL_URL; ?>index.php?controller=pjFront&action=pjActionLoadJs&fid=<?php echo $_GET['id'];?>"&gt;&lt;/script&gt;
&lt;/div&gt;</textarea>