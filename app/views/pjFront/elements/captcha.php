<?php
if(!empty($tpl['field']))
{
    ?>
    <div class="row">
    	<div class="col-sm-12 col-xs-12">
    		<input type="text" name="captcha" maxlength="6" class="form-control pjCF-form-field required" style="width: <?php echo $tpl['field']['size'];?>% !important;float:left; margin-right:10px;"/>
    		<img id="pjCF_captcha_img" src="<?php echo PJ_INSTALL_URL; ?>index.php?controller=pjFront&amp;action=pjActionCaptcha&amp;id=<?php echo $_GET['id']?>&amp;rand=<?php echo rand(1, 999999); ?><?php echo isset($_GET['session_id']) ? "&session_id=" . pjSanitize::clean($_GET['session_id']) : NULL; ?>" alt="Captcha" style="cursor: pointer"/>
    	</div>
    </div>
    <?php
}
?>