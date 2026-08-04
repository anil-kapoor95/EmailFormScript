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
	pjUtil::printNotice(__('infoAddFormTitle', true, false), __('infoAddFormBody', true, false)); 
	?>
	<form action="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminForms&amp;action=pjActionCreate" method="post" id="frmCreateForm" class="form pj-form" autocomplete="off">
		<input type="hidden" name="form_create" value="1" />
		
		<p>
			<label class="title"><?php __('lblFormName'); ?></label>
			<span class="inline_block">
				<input type="text" name="form_title" id="form_title" class="pj-form-field w500 required" />
			</span>
		</p>
		<p>
			<label class="title">&nbsp;</label>
			<input type="submit" value="<?php __('btnSave', false, true); ?>" class="pj-button" />
			<input type="button" value="<?php __('btnCancel'); ?>" class="pj-button" onclick="window.location.href='<?php echo PJ_INSTALL_URL; ?>index.php?controller=pjAdminForms&action=pjActionIndex';" />
		</p>
	</form>
	<?php
}
?>