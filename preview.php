<!DOCTYPE html>
<html>
	<head>
		<title>Contact Form - Preview</title>
		<meta charset="utf-8">
	    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	    <meta name="viewport" content="width=device-width, initial-scale=1">
	    
	    <link href="core/framework/libs/pj/css/pj.bootstrap.min.css" type="text/css" rel="stylesheet" />
	    <link href="index.php?controller=pjFront&action=pjActionLoadCss&fid=<?php echo $_GET['id'];?><?php echo isset($_GET['theme']) ? '&theme=' . $_GET['theme'] : null; ?>" type="text/css" rel="stylesheet" />
	</head>
	<body>
		<div style="max-width: 700px;">
			<script type="text/javascript" src="index.php?controller=pjFront&action=pjActionLoad&fid=<?php echo $_GET['id'];?><?php echo isset($_GET['theme']) ? '&theme=' . $_GET['theme'] : null; ?>"></script>		
		</div>
	</body>
</html>