START TRANSACTION;

INSERT IGNORE INTO `options` (`foreign_id`, `key`, `tab_id`, `value`, `label`, `type`, `order`, `is_visible`, `style`) VALUES
(1, 'o_captcha_provider', 1, 'phpjabbers|recaptcha::phpjabbers', 'PHPJabbers Image Captcha|Google reCAPTCHA', 'enum', 20, 1, NULL),
(1, 'o_recaptcha_site_key', 1, NULL, NULL, 'string', 21, 1, NULL),
(1, 'o_recaptcha_secret_key', 1, NULL, NULL, 'string', 22, 1, NULL);

INSERT IGNORE INTO `fields` (`key`, `type`, `label`, `source`) VALUES ('opt_o_captcha_provider', 'backend', 'Options / Captcha type', 'script');
SET @id := (SELECT `id` FROM `fields` WHERE `key` = 'opt_o_captcha_provider' LIMIT 1);
INSERT IGNORE INTO `multi_lang` (`foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES (@id, 'pjField', '::LOCALE::', 'title', 'Captcha type', 'script');

INSERT IGNORE INTO `fields` (`key`, `type`, `label`, `source`) VALUES ('opt_o_recaptcha_site_key', 'backend', 'Options / reCAPTCHA site key', 'script');
SET @id := (SELECT `id` FROM `fields` WHERE `key` = 'opt_o_recaptcha_site_key' LIMIT 1);
INSERT IGNORE INTO `multi_lang` (`foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES (@id, 'pjField', '::LOCALE::', 'title', 'reCAPTCHA site key', 'script');

INSERT IGNORE INTO `fields` (`key`, `type`, `label`, `source`) VALUES ('opt_o_recaptcha_secret_key', 'backend', 'Options / reCAPTCHA secret key', 'script');
SET @id := (SELECT `id` FROM `fields` WHERE `key` = 'opt_o_recaptcha_secret_key' LIMIT 1);
INSERT IGNORE INTO `multi_lang` (`foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES (@id, 'pjField', '::LOCALE::', 'title', 'reCAPTCHA secret key', 'script');

UPDATE `options` SET `is_visible` = 0
WHERE `tab_id` = 1
  AND `key` IN ('o_send_email', 'o_smtp_host', 'o_smtp_port', 'o_smtp_user', 'o_smtp_pass', 'o_from_email');

  INSERT IGNORE INTO `fields` (`key`,`type`,`label`,`source`) VALUES ('error_titles_ARRAY_AO02','arrays','error_titles_ARRAY_AO02','script');
SET @id := (SELECT `id` FROM `fields` WHERE `key`='error_titles_ARRAY_AO02' LIMIT 1);
INSERT IGNORE INTO `multi_lang` (`foreign_id`,`model`,`locale`,`field`,`content`,`source`) VALUES (@id,'pjField','::LOCALE::','title','Missing reCAPTCHA keys','script');

INSERT IGNORE INTO `fields` (`key`,`type`,`label`,`source`) VALUES ('error_bodies_ARRAY_AO02','arrays','error_bodies_ARRAY_AO02','script');
SET @id := (SELECT `id` FROM `fields` WHERE `key`='error_bodies_ARRAY_AO02' LIMIT 1);
INSERT IGNORE INTO `multi_lang` (`foreign_id`,`model`,`locale`,`field`,`content`,`source`) VALUES (@id,'pjField','::LOCALE::','title','Please enter both the reCAPTCHA site key and secret key when Google reCAPTCHA is selected.','script');

INSERT IGNORE INTO `fields` (`key`,`type`,`label`,`source`) VALUES ('errRecaptchaKeys','backend','Message / reCAPTCHA keys required','script');
SET @id := (SELECT `id` FROM `fields` WHERE `key`='errRecaptchaKeys' LIMIT 1);
INSERT IGNORE INTO `multi_lang` (`foreign_id`,`model`,`locale`,`field`,`content`,`source`) VALUES (@id,'pjField','::LOCALE::','title','Please enter both the reCAPTCHA site key and secret key when Google reCAPTCHA is selected.','script');

INSERT IGNORE INTO `fields` (`key`,`type`,`label`,`source`) VALUES ('lblRecaptchaMock','backend','Label / reCAPTCHA preview caption','script');
SET @id := (SELECT `id` FROM `fields` WHERE `key`='lblRecaptchaMock' LIMIT 1);
INSERT IGNORE INTO `multi_lang` (`foreign_id`,`model`,`locale`,`field`,`content`,`source`) VALUES (@id,'pjField','::LOCALE::','title','I''m not a robot','script');

COMMIT;