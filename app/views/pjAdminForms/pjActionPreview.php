<!DOCTYPE html>
<html>
	<head>
		<title>Contact Form - Preview</title>
		<link href="<?php echo PJ_INSTALL_FOLDER . PJ_FRAMEWORK_LIBS_PATH; ?>pj/css/pj.bootstrap.min.css" type="text/css" rel="stylesheet" />
		<link href="<?php echo PJ_INSTALL_URL; ?>/index.php?controller=pjFront&action=pjActionLoadCss&fid=<?php echo $_GET['id'];?>" type="text/css" rel="stylesheet" />
	<head>
	<body>
		<div style="overflow: hidden;">
			<?php
			if(!empty($tpl['arr']))
			{ 
				?>
				<script type="text/javascript" src="<?php echo PJ_INSTALL_FOLDER; ?>index.php?controller=pjFront&action=pjActionLoad&fid=<?php echo $_GET['id'];?>"></script>
				<?php
			}else{
				__('lblFormNotFound');
			} 
			?>
		</div>
	</body>
</html>