<?php
if(!empty($tpl['field']))
{
    if (isset($tpl['option_arr']['o_captcha_provider']) && $tpl['option_arr']['o_captcha_provider'] == 'recaptcha')
    {
        ?>
        <div class="row">
        	<div class="col-sm-12 col-xs-12">
        		<div class="g-recaptcha" id="pjRecaptcha_<?php echo $_GET['id']; ?>" data-sitekey="<?php echo pjSanitize::clean($tpl['option_arr']['o_recaptcha_site_key']); ?>"></div>
        	</div>
        </div>
        <?php
    }
    else
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
}
?>