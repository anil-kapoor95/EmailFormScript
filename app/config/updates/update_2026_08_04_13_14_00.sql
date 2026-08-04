-- Email Settings update - runs via the script's Update mechanism (pjInstaller).
-- Table names are UNPREFIXED on purpose: the installer prepends the table
-- prefix, and replaces ::LOCALE:: with each installed language id.

-- 1) New options
INSERT IGNORE INTO `options` (`foreign_id`, `key`, `tab_id`, `value`, `label`, `type`, `order`, `is_visible`, `style`) VALUES (1, 'o_smtp_secure', 1, '|ssl|tls::', 'None|SSL|TLS', 'enum', 9, 0, NULL), (1, 'o_smtp_auth', 1, 'LOGIN|PLAIN|CRAM-MD5|XOAUTH2::LOGIN', 'LOGIN|PLAIN|CRAM-MD5|XOAUTH2', 'enum', 9, 0, NULL), (1, 'o_from_name', 1, NULL, NULL, 'string', 11, 0, NULL);

-- 2) Translatable labels/messages (field + per-language content)
INSERT IGNORE INTO `fields` (`key`, `type`, `label`, `source`) VALUES ('menuEmailSettings', 'backend', 'Menu / Email Settings', 'script');
SET @id := (SELECT `id` FROM `fields` WHERE `key` = 'menuEmailSettings' LIMIT 1);
INSERT IGNORE INTO `multi_lang` (`foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES (@id, 'pjField', '::LOCALE::', 'title', 'Email Settings', 'script');

INSERT IGNORE INTO `fields` (`key`, `type`, `label`, `source`) VALUES ('lblEmailSettings', 'backend', 'Label / Email Settings', 'script');
SET @id := (SELECT `id` FROM `fields` WHERE `key` = 'lblEmailSettings' LIMIT 1);
INSERT IGNORE INTO `multi_lang` (`foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES (@id, 'pjField', '::LOCALE::', 'title', 'Email Settings', 'script');

INSERT IGNORE INTO `fields` (`key`, `type`, `label`, `source`) VALUES ('infoEmailSettingsSaved', 'backend', 'Label / Email settings saved', 'script');
SET @id := (SELECT `id` FROM `fields` WHERE `key` = 'infoEmailSettingsSaved' LIMIT 1);
INSERT IGNORE INTO `multi_lang` (`foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES (@id, 'pjField', '::LOCALE::', 'title', 'Your email settings have been saved.', 'script');

INSERT IGNORE INTO `fields` (`key`, `type`, `label`, `source`) VALUES ('opt_o_smtp_secure', 'backend', 'Options / SMTP security', 'script');
SET @id := (SELECT `id` FROM `fields` WHERE `key` = 'opt_o_smtp_secure' LIMIT 1);
INSERT IGNORE INTO `multi_lang` (`foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES (@id, 'pjField', '::LOCALE::', 'title', 'SMTP security', 'script');

INSERT IGNORE INTO `fields` (`key`, `type`, `label`, `source`) VALUES ('opt_o_smtp_auth', 'backend', 'Options / SMTP authentication', 'script');
SET @id := (SELECT `id` FROM `fields` WHERE `key` = 'opt_o_smtp_auth' LIMIT 1);
INSERT IGNORE INTO `multi_lang` (`foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES (@id, 'pjField', '::LOCALE::', 'title', 'SMTP authentication', 'script');

INSERT IGNORE INTO `fields` (`key`, `type`, `label`, `source`) VALUES ('opt_o_from_name', 'backend', 'Options / Sender name', 'script');
SET @id := (SELECT `id` FROM `fields` WHERE `key` = 'opt_o_from_name' LIMIT 1);
INSERT IGNORE INTO `multi_lang` (`foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES (@id, 'pjField', '::LOCALE::', 'title', 'Sender name', 'script');

INSERT IGNORE INTO `fields` (`key`, `type`, `label`, `source`) VALUES ('lblNone', 'backend', 'Label / None', 'script');
SET @id := (SELECT `id` FROM `fields` WHERE `key` = 'lblNone' LIMIT 1);
INSERT IGNORE INTO `multi_lang` (`foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES (@id, 'pjField', '::LOCALE::', 'title', 'None', 'script');

INSERT IGNORE INTO `fields` (`key`, `type`, `label`, `source`) VALUES ('btnTestConnection', 'backend', 'Button / Test connection', 'script');
SET @id := (SELECT `id` FROM `fields` WHERE `key` = 'btnTestConnection' LIMIT 1);
INSERT IGNORE INTO `multi_lang` (`foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES (@id, 'pjField', '::LOCALE::', 'title', 'Test connection', 'script');

INSERT IGNORE INTO `fields` (`key`, `type`, `label`, `source`) VALUES ('btnSendTestEmail', 'backend', 'Button / Send test email', 'script');
SET @id := (SELECT `id` FROM `fields` WHERE `key` = 'btnSendTestEmail' LIMIT 1);
INSERT IGNORE INTO `multi_lang` (`foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES (@id, 'pjField', '::LOCALE::', 'title', 'Send test email', 'script');

INSERT IGNORE INTO `fields` (`key`, `type`, `label`, `source`) VALUES ('emailMsgEnterHostPort', 'backend', 'Message / Enter SMTP host and port', 'script');
SET @id := (SELECT `id` FROM `fields` WHERE `key` = 'emailMsgEnterHostPort' LIMIT 1);
INSERT IGNORE INTO `multi_lang` (`foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES (@id, 'pjField', '::LOCALE::', 'title', 'Please enter the SMTP host and port first.', 'script');

INSERT IGNORE INTO `fields` (`key`, `type`, `label`, `source`) VALUES ('emailMsgConnOk', 'backend', 'Message / SMTP connection ok', 'script');
SET @id := (SELECT `id` FROM `fields` WHERE `key` = 'emailMsgConnOk' LIMIT 1);
INSERT IGNORE INTO `multi_lang` (`foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES (@id, 'pjField', '::LOCALE::', 'title', 'Connection successful - your SMTP settings are correct.', 'script');

INSERT IGNORE INTO `fields` (`key`, `type`, `label`, `source`) VALUES ('emailMsgConnFail', 'backend', 'Message / SMTP connection failed', 'script');
SET @id := (SELECT `id` FROM `fields` WHERE `key` = 'emailMsgConnFail' LIMIT 1);
INSERT IGNORE INTO `multi_lang` (`foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES (@id, 'pjField', '::LOCALE::', 'title', 'Connection failed. Please check your SMTP settings.', 'script');

INSERT IGNORE INTO `fields` (`key`, `type`, `label`, `source`) VALUES ('emailMsgEnterValidEmail', 'backend', 'Message / Enter valid email', 'script');
SET @id := (SELECT `id` FROM `fields` WHERE `key` = 'emailMsgEnterValidEmail' LIMIT 1);
INSERT IGNORE INTO `multi_lang` (`foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES (@id, 'pjField', '::LOCALE::', 'title', 'Please enter a valid email address.', 'script');

INSERT IGNORE INTO `fields` (`key`, `type`, `label`, `source`) VALUES ('emailMsgEnterEmail', 'backend', 'Message / Enter email', 'script');
SET @id := (SELECT `id` FROM `fields` WHERE `key` = 'emailMsgEnterEmail' LIMIT 1);
INSERT IGNORE INTO `multi_lang` (`foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES (@id, 'pjField', '::LOCALE::', 'title', 'Please enter an email address.', 'script');

INSERT IGNORE INTO `fields` (`key`, `type`, `label`, `source`) VALUES ('emailMsgSentOk', 'backend', 'Message / Test email sent', 'script');
SET @id := (SELECT `id` FROM `fields` WHERE `key` = 'emailMsgSentOk' LIMIT 1);
INSERT IGNORE INTO `multi_lang` (`foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES (@id, 'pjField', '::LOCALE::', 'title', 'A test email has been sent to', 'script');

INSERT IGNORE INTO `fields` (`key`, `type`, `label`, `source`) VALUES ('emailMsgCheckInbox', 'backend', 'Message / Check inbox', 'script');
SET @id := (SELECT `id` FROM `fields` WHERE `key` = 'emailMsgCheckInbox' LIMIT 1);
INSERT IGNORE INTO `multi_lang` (`foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES (@id, 'pjField', '::LOCALE::', 'title', 'Please check the inbox (and the spam folder).', 'script');

INSERT IGNORE INTO `fields` (`key`, `type`, `label`, `source`) VALUES ('emailMsgSendFail', 'backend', 'Message / Test email failed', 'script');
SET @id := (SELECT `id` FROM `fields` WHERE `key` = 'emailMsgSendFail' LIMIT 1);
INSERT IGNORE INTO `multi_lang` (`foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES (@id, 'pjField', '::LOCALE::', 'title', 'The test email could not be sent. Please verify your settings.', 'script');

INSERT IGNORE INTO `fields` (`key`, `type`, `label`, `source`) VALUES ('emailMsgPrompt', 'backend', 'Message / Prompt test email address', 'script');
SET @id := (SELECT `id` FROM `fields` WHERE `key` = 'emailMsgPrompt' LIMIT 1);
INSERT IGNORE INTO `multi_lang` (`foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES (@id, 'pjField', '::LOCALE::', 'title', 'Enter the email address to send the test email to:', 'script');

INSERT IGNORE INTO `fields` (`key`, `type`, `label`, `source`) VALUES ('emailMsgTesting', 'backend', 'Message / Testing connection', 'script');
SET @id := (SELECT `id` FROM `fields` WHERE `key` = 'emailMsgTesting' LIMIT 1);
INSERT IGNORE INTO `multi_lang` (`foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES (@id, 'pjField', '::LOCALE::', 'title', 'Testing SMTP connection, please wait...', 'script');

INSERT IGNORE INTO `fields` (`key`, `type`, `label`, `source`) VALUES ('emailMsgSending', 'backend', 'Message / Sending test email', 'script');
SET @id := (SELECT `id` FROM `fields` WHERE `key` = 'emailMsgSending' LIMIT 1);
INSERT IGNORE INTO `multi_lang` (`foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES (@id, 'pjField', '::LOCALE::', 'title', 'Sending test email, please wait...', 'script');

INSERT IGNORE INTO `fields` (`key`, `type`, `label`, `source`) VALUES ('emailMsgUnexpected', 'backend', 'Message / Unexpected error', 'script');
SET @id := (SELECT `id` FROM `fields` WHERE `key` = 'emailMsgUnexpected' LIMIT 1);
INSERT IGNORE INTO `multi_lang` (`foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES (@id, 'pjField', '::LOCALE::', 'title', 'An unexpected error occurred.', 'script');

INSERT IGNORE INTO `fields` (`key`, `type`, `label`, `source`) VALUES ('emailTestModalTitle', 'backend', 'Label / Send test email modal title', 'script');
SET @id := (SELECT `id` FROM `fields` WHERE `key` = 'emailTestModalTitle' LIMIT 1);
INSERT IGNORE INTO `multi_lang` (`foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES (@id, 'pjField', '::LOCALE::', 'title', 'Send Test Email', 'script');

INSERT IGNORE INTO `fields` (`key`, `type`, `label`, `source`) VALUES ('emailTestModalDesc', 'backend', 'Label / Send test email modal description', 'script');
SET @id := (SELECT `id` FROM `fields` WHERE `key` = 'emailTestModalDesc' LIMIT 1);
INSERT IGNORE INTO `multi_lang` (`foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES (@id, 'pjField', '::LOCALE::', 'title', 'Enter your email address and a test message will be sent to it to verify that the system is able to send emails.', 'script');

INSERT IGNORE INTO `fields` (`key`, `type`, `label`, `source`) VALUES ('lblEmailAddress', 'backend', 'Label / Email address', 'script');
SET @id := (SELECT `id` FROM `fields` WHERE `key` = 'lblEmailAddress' LIMIT 1);
INSERT IGNORE INTO `multi_lang` (`foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES (@id, 'pjField', '::LOCALE::', 'title', 'Email Address:', 'script');

INSERT IGNORE INTO `fields` (`key`, `type`, `label`, `source`) VALUES ('btnCancel', 'backend', 'Button / Cancel', 'script');
SET @id := (SELECT `id` FROM `fields` WHERE `key` = 'btnCancel' LIMIT 1);
INSERT IGNORE INTO `multi_lang` (`foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES (@id, 'pjField', '::LOCALE::', 'title', 'Cancel', 'script');

INSERT IGNORE INTO `fields` (`key`, `type`, `label`, `source`) VALUES ('btnSendEmail', 'backend', 'Button / Send email', 'script');
SET @id := (SELECT `id` FROM `fields` WHERE `key` = 'btnSendEmail' LIMIT 1);
INSERT IGNORE INTO `multi_lang` (`foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES (@id, 'pjField', '::LOCALE::', 'title', 'Send Email', 'script');

