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
} else {
	$titles = __('error_titles', true);
	$bodies = __('error_bodies', true);
	if (isset($_GET['err']))
	{
		pjUtil::printNotice(@$titles[$_GET['err']], @$bodies[$_GET['err']]);
	}
	?>
	
	<form action="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminForms&amp;action=pjActionUpdate" method="post" id="frmUpdateForm" class="form pj-form">
		<input type="hidden" name="form_update" value="1" />
		<input type="hidden" id="id" name="id" value="<?php echo $tpl['arr']['id']; ?>" />
		<input type="hidden" name="tab_id" value="<?php echo isset($_GET['tab_id']) && !empty($_GET['tab_id']) ? $_GET['tab_id'] : 'tabs-1'; ?>" />
		
		<div class="b10"><?php __('lblForm');?>: <strong class="bold"><?php echo pjSanitize::html($tpl['arr']['form_title']); ?></strong>   <a href="preview.php?id=<?php echo $tpl['arr']['id'];?>" target="_blank"><?php __('lblPreview');?></a></div>
		
		<div id="tabs">
		
			<ul>
				<li><a href="#tabs-1"><?php __('lblFormFields'); ?></a></li>
				<li><a href="#tabs-2"><?php __('lblFormDetails'); ?></a></li>
				<li><a href="#tabs-3"><?php __('lblFormStyles'); ?></a></li>
				<li><a href="#tabs-4"><?php __('lblAutoResponder'); ?></a></li>
				<li><a href="#tabs-5"><?php __('lblConfirmationEmail'); ?></a></li>
				<li><a href="#tabs-6"><?php __('lblInstall'); ?></a></li>
			</ul>
		
			<div id="tabs-1">
				<?php
				pjUtil::printNotice(__('infoFormFieldTitle', true, false), __('infoFormFieldBody', true, false)); 
				?>
				<div id="designer_panel" class="designer-panel">
					<?php
					include PJ_VIEWS_PATH . 'pjAdminForms/elements/form.php'; 
					?>
				</div>
				<div id="toolbox_panel" class="toolbox-panel">
					<?php
					include PJ_VIEWS_PATH . 'pjAdminForms/elements/toolbox.php'; 
					?>
				</div>
				<div id="property_panel" class="property-panel">
					<?php
					include PJ_VIEWS_PATH . 'pjAdminForms/elements/property.php'; 
					?>
				</div>
			</div><!-- tabs-1 -->
			<div id="tabs-2">
				<?php
				pjUtil::printNotice(__('infoFormDetailTitle', true, false), __('infoFormDetailBody', true, false)); 
				?>
				<p>
					<label class="title"><?php __('lblFormName', false, true); ?></label>
					<span class="inline_block">
						<input type="text" name="form_title" id="form_title" value="<?php echo pjSanitize::html($tpl['arr']['form_title']);?>" class="pj-form-field w500 required" />
					</span>
				</p>
				<p>
					<label class="title"><?php __('lblDateFormat', false, true); ?></label>
					<span class="inline_block">
						<select name="date_format" id="date_format" class="pj-form-field w200">
							<?php
							foreach (pjUtil::getDateFormat() as $k => $v)
							{
								?><option value="<?php echo $k; ?>" <?php echo $tpl['arr']['date_format'] == $k ? 'selected="selected"' : null; ?>><?php echo $v; ?></option><?php
							}
							?>
						</select>
						<a href="#" class="pj-form-langbar-tip listing-tip" title="<?php __('lblDateFormatTip', false, true); ?>"></a>
					</span>
				</p>
				<p>
					<label class="title"><?php __('lblSendTo'); ?></label>
					<span class="inline_block">
						<select id="user_id" name="user_id[]" class="pj-form-field w400" data-placeholder="--<?php __('lblChoose'); ?>--" multiple="multiple">
							<?php
							foreach ($tpl['user_arr'] as $k => $v)
							{
								?><option value="<?php echo $v['id']; ?>" <?php echo in_array($v['id'], $tpl['user_id_arr']) ? 'selected="selected"' : null; ?>><?php echo $v['name']; ?></option><?php
							}
							?>
						</select>
						<a href="#" class="pj-form-langbar-tip center-langbar-tip" title="<?php __('lblSendToTip'); ?>"></a>
					</span>
				</p>
				
				<p>
					<label class="title"><?php __('lblEmailFormat', false, true); ?></label>
					<span class="inline_block">
						<select name="email_type" id="email_type" class="pj-form-field w100">
							<?php
							foreach (__('email_format', true) as $k => $v)
							{
								?><option value="<?php echo $k; ?>" <?php echo $tpl['arr']['email_type'] == $k ? 'selected="selected"' : null; ?>><?php echo $v; ?></option><?php
							}
							?>
						</select>
						<a href="#" class="pj-form-langbar-tip listing-tip" title="<?php __('lblEmailFormatTip', false, true); ?>"></a>
					</span>
				</p>
				<p>
					<label class="title"><?php __('lblConfirmationOptions', false, true); ?></label>
					<span class="inline_block">
						<select name="confirm_options" id="confirm_options" class="pj-form-field w200">
							<?php
							foreach (__('confirm_options', true) as $k => $v)
							{
								?><option value="<?php echo $k; ?>" <?php echo $tpl['arr']['confirm_options'] == $k ? 'selected="selected"' : null; ?>><?php echo $v; ?></option><?php
							}
							?>
						</select>
						<a href="#" class="pj-form-langbar-tip listing-tip" title="<?php __('lblConfirmationOptionsTip', false, true); ?>"></a>
					</span>
				</p>
				<p class="confirm-message">
					<label class="title"><?php __('lblConfirmationMessage', false, true); ?></label>
					<span class="inline_block">
						<input type="text" name="confirm_message" id="confirm_message" value="<?php echo pjSanitize::html($tpl['arr']['confirm_message']);?>" class="pj-form-field w400" />
					</span>
				</p>
				<p class="confirm-redirect">
					<label class="title"><?php __('lblRedirectURL', false, true); ?></label>
					<span class="pj-form-field-custom pj-form-field-custom-before">
						<span class="pj-form-field-before"><abbr class="pj-form-field-icon-url"></abbr></span>
						<input type="text" name="thankyou_page" id="thankyou_page" class="pj-form-field w400" value="<?php echo !empty($tpl['arr']['thankyou_page']) ? htmlspecialchars(stripslashes($tpl['arr']['thankyou_page'])) : 'http://'; ?>" placeholder="http://www.domain.com"  />
					</span>
				</p>
				<?php if (isset($tpl['option_arr']['o_captcha_provider']) && $tpl['option_arr']['o_captcha_provider'] == 'recaptcha') { ?>
				<input type="hidden" name="captcha_type" value="<?php echo htmlspecialchars($tpl['arr']['captcha_type']); ?>" />
				<?php } else { ?>
				<p>
					<label class="title"><?php __('lblCaptchaType', false, true); ?></label>
					<span class="inline_block">
						<select name="captcha_type" id="captcha_type" class="pj-form-field w150">
							<?php
							foreach (__('captcha_types', true) as $k => $v)
							{
								?><option value="<?php echo $k; ?>" <?php echo $tpl['arr']['captcha_type'] == $k ? 'selected="selected"' : null; ?>><?php echo $v; ?></option><?php
							}
							?>
						</select>
					</span>
				</p>
				<?php } ?>
				<p>
					<label class="title"><?php __('lblRejectLinks', false, true); ?></label>
					<span class="inline_block">
						<select name="reject_links" id="reject_links" class="pj-form-field w100">
							<?php
							foreach (__('_yesno', true) as $k => $v)
							{
								?><option value="<?php echo $k; ?>" <?php echo $tpl['arr']['reject_links'] == $k ? 'selected="selected"' : null; ?>><?php echo $v; ?></option><?php
							}
							?>
						</select>
						<a href="#" class="pj-form-langbar-tip listing-tip" title="<?php __('lblRejectLinksTip', false, true); ?>"></a>
					</span>
				</p>
				<p>
					<label class="title"><?php __('lblBlockWords', false, true); ?></label>
					<span class="inline_block">
						<textarea id="block_words" name="block_words" class="pj-form-field w400 h120"><?php echo pjSanitize::clean($tpl['arr']['block_words'])?></textarea>
						<a href="#" class="pj-form-langbar-tip center-langbar-tip" title="<?php __('lblBlockWordsTip'); ?>"></a>
					</span>
				</p>				
				<p>
					<label class="title">&nbsp;</label>
					<input type="submit" value="<?php __('btnSave', false, true); ?>" class="pj-button" />
				</p>
			</div><!-- tabs-2 -->
			<div id="tabs-3">
				<?php
				pjUtil::printNotice(__('infoFormStylesTitle', true, false), __('infoFormStylesBody', true, false)); 
				
				$label_position = __('label_position', true); 
				?>
				<p>
					<label class="title"><?php __('lblLabelPosition', false, true); ?></label>
					<span class="inline_block">
						<select name="label_position" id="label_position" class="pjFormStyles pj-form-field w200">
							<?php
							foreach ($label_position as $k => $v)
							{
								?><option value="<?php echo $k; ?>" <?php echo $tpl['arr']['label_position'] == $k ? 'selected="selected"' : null; ?>><?php echo $v; ?></option><?php
							}
							?>
						</select>
					</span>
				</p>
				<p>
					<label class="title"><?php __('lblFontFamily', false, true); ?></label>
					<span class="inline_block">
						<select name="font_family" id="font_family" class="pjFormStyles pj-form-field">
							<option value="">-- <?php __('lblChoose', false, true); ?>--</option>
							<?php
							foreach (pjUtil::getFonts() as $k => $v)
							{
								?><option value="<?php echo $k; ?>" <?php echo $tpl['arr']['font_family'] == $k ? 'selected="selected"' : null; ?>><?php echo $v; ?></option><?php
							}
							?>
						</select>
					</span>
				</p>
				<p>
					<label class="title"><?php __('lblFontSize', false, true); ?></label>
					<span class="inline_block">
						<select name="font_size" id="font_size" class="pjFormStyles pj-form-field">
							<option value="">-- <?php __('lblChoose', false, true); ?>--</option>
							<?php
							foreach (pjUtil::getFontSizes() as $k => $v)
							{
								?><option value="<?php echo $k; ?>" <?php echo $tpl['arr']['font_size'] == $k ? 'selected="selected"' : null; ?>><?php echo $v; ?></option><?php
							}
							?>
						</select>
					</span>
				</p>
				<p>
					<label class="title"><?php __('lblFontColor', false, true); ?></label>
					<input type="text" id="font_color" name="font_color" class="pjFormStyles pj-form-field field-color w80" value="<?php echo pjSanitize::html($tpl['arr']['font_color']);?>"  />
				</p>
				<p>
					<label class="title"><?php __('lblBackgroundColor', false, true); ?></label>
					<span class="inline_block">
						<input type="text" id="background_color" name="background_color" class="pjFormStyles pj-form-field mini-color w80" value="<?php echo pjSanitize::html($tpl['arr']['background_color']);?>"  />
					</span>
				</p>
				<p>
					<label class="title"><?php __('lblFieldBackgroundColor', false, true); ?></label>
					<span class="inline_block">
						<input type="text" id="field_background_color" name="field_background_color" class="pjFormStyles pj-form-field mini-color w80" value="<?php echo pjSanitize::html($tpl['arr']['field_background_color']);?>"  />
					</span>
				</p>
				<p>
					<label class="title"><?php __('lblButtonBackgroundColor', false, true); ?></label>
					<span class="inline_block">
						<input type="text" id="button_background_color" name="button_background_color" class="pjFormStyles pj-form-field mini-color w80" value="<?php echo pjSanitize::html($tpl['arr']['button_background_color']);?>"  />
					</span>
				</p>
				<p>
					<label class="title"><?php __('lblButtonHoverBackgroundColor', false, true); ?></label>
					<span class="inline_block">
						<input type="text" id="button_hover_background_color" name="button_hover_background_color" class="pjFormStyles pj-form-field mini-color w80" value="<?php echo pjSanitize::html($tpl['arr']['button_hover_background_color']);?>"  />
					</span>
				</p>
				<p>
					<label class="title"><?php __('lblButtonBorderColor', false, true); ?></label>
					<span class="inline_block">
						<input type="text" id="button_border_color" name="button_border_color" class="pjFormStyles pj-form-field field-color w80" value="<?php echo pjSanitize::html($tpl['arr']['button_border_color']);?>"  />
					</span>
				</p>
				<p>
					<label class="title"><?php __('lblButtonHoverBorderColor', false, true); ?></label>
					<span class="inline_block">
						<input type="text" id="button_hover_border_color" name="button_hover_border_color" class="pjFormStyles pj-form-field field-color w80" value="<?php echo pjSanitize::html($tpl['arr']['button_hover_border_color']);?>"  />
					</span>
				</p>
				<p>
					<label class="title">&nbsp;</label>
					<input type="submit" value="<?php __('btnSave', false, true); ?>" class="pj-button float_left r5" />
					<a href="preview.php?id=<?php echo $tpl['arr']['id'];?>" target="_blank" class="no-decor pjCF-preview-form"><?php __('btnPreviewForm', false, true); ?></a>
				</p>
			</div><!-- tabs-3 -->
			<div id="tabs-4">
				<?php
				pjUtil::printNotice(__('infoAutoResponseTitle', true, false), __('infoAutoResponseBody', true, false)); 
				?>
				<p>
					<label class="title"><?php __('lblAutoSubject', false, true); ?></label>
					<span class="inline_block">
						<input type="text" name="auto_subject" id="auto_subject" value="<?php echo pjSanitize::html($tpl['arr']['auto_subject']);?>" class="pj-form-field w500" />
					</span>
				</p>
				<p>
					<label class="title"><?php __('lblAutoMessage', false, true); ?></label>
					<span class="inline_block">
						<textarea name="auto_message" id="auto_message" class="pj-form-field mceEditor" ><?php echo pjSanitize::html($tpl['arr']['auto_message']);?></textarea>
					</span>
				</p>
				<p>
					<label class="title">&nbsp;</label>
					<input type="submit" value="<?php __('btnSave', false, true); ?>" class="pj-button" />
				</p>
			</div><!-- tabs-3 -->
			<div id="tabs-5">
				<?php
				pjUtil::printNotice(__('infoConfirmationEmailTitle', true, false), __('infoConfirmationEmailDesc', true, false)); 
				?>
				<p>
					<label class="title"><?php __('lblAutoSubject', false, true); ?></label>
					<span class="inline_block">
						<input type="text" name="subject" id="subject" value="<?php echo pjSanitize::html($tpl['arr']['subject']);?>" class="pj-form-field w400" />
					</span>
				</p>
				<p>
					<label class="title"><?php __('lblAutoMessage', false, true); ?></label>
					<span class="inline_block">
						<textarea name="message" id="message" class="pj-form-field mceEditor" ><?php echo pjSanitize::html($tpl['arr']['message']);?></textarea>
					</span>
				</p>
				<p>
					<label class="title">&nbsp;</label>
					<input type="submit" value="<?php __('btnSave', false, true); ?>" class="pj-button" />
				</p>
			</div><!-- tabs-3 -->
			<div id="tabs-6">
				<div id="install_tabs">
					<ul>
						<li><a href="#install_tabs-1"><?php __('lblJavascript'); ?></a></li>
						<li><a href="#install_tabs-2"><?php __('lblFormSourceCode'); ?></a></li>
					</ul>
					<div id="install_tabs-1">
						<?php
						pjUtil::printNotice(null, __('infoJSInstallBody', true, false)); 
						?>
					<textarea class="pj-form-field textarea_install" id="install_code" style="overflow: auto; height:100px;width: 726px;">
&lt;link href="<?php echo PJ_INSTALL_URL.PJ_FRAMEWORK_LIBS_PATH; ?>pj/css/pj.bootstrap.min.css" type="text/css" rel="stylesheet" /&gt;
&lt;link href="<?php echo PJ_INSTALL_URL; ?>index.php?controller=pjFront&action=pjActionLoadCss&fid=<?php echo $tpl['arr']['id']; ?>" type="text/css" rel="stylesheet" /&gt;
&lt;script type="text/javascript" src="<?php echo PJ_INSTALL_URL; ?>index.php?controller=pjFront&action=pjActionLoad&fid=<?php echo $tpl['arr']['id']; ?>"&gt;&lt;/script&gt;</textarea>
					</div>
					<div id="install_tabs-2">
						<?php
						pjUtil::printNotice(null, __('infoHTMLInstallBody', true, false)); 
						?>
						<div id="install_html_code"><img src="<?php echo PJ_INSTALL_URL . PJ_IMG_PATH ?>backend/loader.gif" /></div>
					</div>
				</div>
			</div><!-- tabs-3 -->
			
		</div> <!-- #tabs -->
	</form>
	
	<div id="dialogDeleteField" style="display: none" title="<?php __('lblDeleteField');?>"><?php __('lblDeleteFieldConfirm');?></div>
	<div id="dialogView" style="display: none" title="<?php echo $tpl['arr']['form_title'];?>"></div>
	<div id="record_id" style="display: none"></div>
	<div id="form_id" style="display: none"><?php echo $tpl['arr']['id']; ?></div>
	<div id="field_type" style="display: none"></div>
	<script type="text/javascript">
		var pjGrid = pjGrid || {};
		pjGrid.roleId = <?php echo (int) $_SESSION[$controller->defaultUser]['role_id']; ?>;
		var myLabel = myLabel || {};
		myLabel.form_id = "<?php echo $tpl['arr']['id']; ?>";
		myLabel.valid_url = "<?php __('lblInvalidUrl', false, true); ?>";
		myLabel.delete_selected = "<?php __('delete_selected', false, true); ?>";
		myLabel.delete_confirmation = "<?php __('delete_confirmation', false, true); ?>";
	</script>
	
	<?php
	if (isset($_GET['tab_id']) && !empty($_GET['tab_id']))
	{
		$tab_id = explode("-", $_GET['tab_id']);
		$tab_id = (int) $tab_id[1] - 1;
		$tab_id = $tab_id < 0 ? 0 : $tab_id;
		?>
		<script type="text/javascript">
		(function ($) {
			$(function () {
				$("#tabs").tabs("option", "active", <?php echo $tab_id; ?>);
			});
		})(jQuery_1_8_2);
		</script>
		<?php
	}
}
?>