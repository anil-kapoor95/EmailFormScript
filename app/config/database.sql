DROP TABLE IF EXISTS `contactform_forms`;
CREATE TABLE IF NOT EXISTS `contactform_forms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `form_title` varchar(255) DEFAULT NULL,
  `form_width` int(11) DEFAULT '550',
  `label_width` int(11) DEFAULT '80',
  `label_position` enum('right','left','top') NOT NULL DEFAULT 'right',  
  `date_format` varchar(20) DEFAULT 'd-m-Y',
  `confirm_options` enum('message','redirect') NOT NULL DEFAULT 'message',
  `confirm_message` varchar(255) DEFAULT NULL,
  `thankyou_page` varchar(255) DEFAULT NULL,
  `send_to` varchar(255) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `auto_subject` varchar(255) DEFAULT NULL,
  `auto_message` text DEFAULT NULL,
  `email_type` enum('html','text') DEFAULT 'html',
  `captcha_type` enum('string','math') DEFAULT 'string',
  `reject_links` enum('T','F') DEFAULT 'F',
  `block_words` text DEFAULT NULL,
  `font_family` varchar(50) DEFAULT 'Arial',
  `font_size` int(4) DEFAULT '12',
  `font_color` varchar(10) DEFAULT '000000',
  `background_color` varchar(10) DEFAULT 'FFFFFF',
  `field_background_color` varchar(10) DEFAULT 'FFFFFF',
  `button_background_color` varchar(10) DEFAULT 'FFFFFF',
  `button_border_color` varchar(10) DEFAULT 'CCCCCC',
  `button_hover_border_color` varchar(10) DEFAULT 'adadad',
  `button_hover_background_color` varchar(10) DEFAULT 'e6e6e6',
  `modified` datetime DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `status` enum('T','F') NOT NULL DEFAULT 'T',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `contactform_formfields`;
CREATE TABLE IF NOT EXISTS `contactform_formfields` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `form_id` int(11) unsigned NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL, 
  `label` varchar(255) DEFAULT NULL, 
  `default_value` varchar(255) DEFAULT NULL,
  `send_confirmation` enum('T','F') DEFAULT 'T',
  `hint` varchar(255) DEFAULT NULL,
  `size` int(10) DEFAULT '30',
  `maxlength` int(10) DEFAULT NULL,
  `columns` int(10) DEFAULT '100',
  `rows` int(10) DEFAULT '150',
  `option_data` text DEFAULT NULL,
  `max_file_size` int(4) DEFAULT '1',
  `extensions` varchar(255) DEFAULT NULL,
  `allow_mulitple` enum('T','F') DEFAULT 'F',
  `validate_image` enum('T','F') DEFAULT 'F',
  `heading_size` enum('small','medium','large') DEFAULT 'medium',
  `required` enum('T','F') DEFAULT 'F', 
  `validation` enum('none','url','numeric','alphabetic','alphanumeric') DEFAULT 'none', 
  `error_required` varchar(255) DEFAULT NULL,
  `error_email` varchar(255) DEFAULT NULL,
  `error_validation` varchar(255) DEFAULT NULL,
  `error_maxsize` varchar(255) DEFAULT NULL,
  `error_extensions` varchar(255) DEFAULT NULL,
  `error_incorrect` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `form_id` (`form_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `contactform_users_forms`;
CREATE TABLE IF NOT EXISTS `contactform_users_forms` (
  `user_id` int(10) NOT NULL,
  `form_id` int(10) NOT NULL,
  PRIMARY KEY (`user_id`, `form_id`),
  KEY `user_id` (`user_id`),
  KEY `form_id` (`form_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `contactform_fields`;
CREATE TABLE IF NOT EXISTS `contactform_fields` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(100) DEFAULT NULL,
  `type` enum('backend','frontend','arrays') DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `source` enum('script','plugin') DEFAULT 'script',
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `contactform_files`;
CREATE TABLE IF NOT EXISTS `contactform_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `form_id` int(10) DEFAULT NULL,
  `submission_id` int(10) DEFAULT NULL,
  `field_id` int(10) DEFAULT NULL,
  `mime_type` varchar(255) DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `hash` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `form_id` (`form_id`),
  KEY `submission_id` (`submission_id`),
  KEY `field_id` (`field_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `contactform_submissions`;
CREATE TABLE IF NOT EXISTS `contactform_submissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `form_id` int(10) DEFAULT NULL,
  `ip` varchar(50) DEFAULT NULL,
  `submitted_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `form_id` (`form_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `contactform_submission_details`;
CREATE TABLE IF NOT EXISTS `contactform_submission_details` (
  `form_id` int(10) NOT NULL,
  `submission_id` int(10) NOT NULL,
  `field_id` int(10) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `value` text DEFAULT NULL,
  PRIMARY KEY (`submission_id`, `field_id`),
  KEY `form_id` (`form_id`),
  KEY `submission_id` (`submission_id`),
  KEY `field_id` (`field_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `contactform_multi_lang`;
CREATE TABLE IF NOT EXISTS `contactform_multi_lang` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `foreign_id` int(10) unsigned DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `locale` tinyint(3) unsigned DEFAULT NULL,
  `field` varchar(50) DEFAULT NULL,
  `content` text,
  `source` enum('script','plugin','data') DEFAULT 'script',
  PRIMARY KEY (`id`),
  UNIQUE KEY `foreign_id` (`foreign_id`,`model`,`locale`,`field`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `contactform_options`;
CREATE TABLE IF NOT EXISTS `contactform_options` (
  `foreign_id` int(10) unsigned NOT NULL DEFAULT '0',
  `key` varchar(255) NOT NULL DEFAULT '',
  `tab_id` tinyint(3) unsigned DEFAULT NULL,
  `value` text,
  `label` text,
  `type` enum('string','text','int','float','enum','bool') NOT NULL DEFAULT 'string',
  `order` int(10) unsigned DEFAULT NULL,
  `is_visible` tinyint(1) unsigned DEFAULT '1',
  `style` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`foreign_id`,`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `contactform_roles`;
CREATE TABLE IF NOT EXISTS `contactform_roles` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `role` varchar(255) DEFAULT NULL,
  `status` enum('T','F') NOT NULL DEFAULT 'T',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `contactform_users`;
CREATE TABLE IF NOT EXISTS `contactform_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(10) unsigned NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` blob,
  `name` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `created` datetime NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `status` enum('T','F') NOT NULL DEFAULT 'T',
  `is_active` enum('T','F') NOT NULL DEFAULT 'F',
  `ip` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `role_id` (`role_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;



INSERT INTO `contactform_options` (`foreign_id`, `key`, `tab_id`, `value`, `label`, `type`, `order`, `is_visible`, `style`) VALUES
(1, 'o_date_format', 1, 'd.m.Y|m.d.Y|Y.m.d|j.n.Y|n.j.Y|Y.n.j|d/m/Y|m/d/Y|Y/m/d|j/n/Y|n/j/Y|Y/n/j|d-m-Y|m-d-Y|Y-m-d|j-n-Y|n-j-Y|Y-n-j::d-m-Y', 'd.m.Y (25.09.2012)|m.d.Y (09.25.2012)|Y.m.d (2012.09.25)|j.n.Y (25.9.2012)|n.j.Y (9.25.2012)|Y.n.j (2012.9.25)|d/m/Y (25/09/2012)|m/d/Y (09/25/2012)|Y/m/d (2012/09/25)|j/n/Y (25/9/2012)|n/j/Y (9/25/2012)|Y/n/j (2012/9/25)|d-m-Y (25-09-2012)|m-d-Y (09-25-2012)|Y-m-d (2012-09-25)|j-n-Y (25-9-2012)|n-j-Y (9-25-2012)|Y-n-j (2012-9-25)', 'enum', 1, 1, NULL),
(1, 'o_time_format', 1, 'H:i|G:i|h:i|h:i a|h:i A|g:i|g:i a|g:i A::H:i', 'H:i (09:45)|G:i (9:45)|h:i (09:45)|h:i a (09:45 am)|h:i A (09:45 AM)|g:i (9:45)|g:i a (9:45 am)|g:i A (9:45 AM)', 'enum', 2, 1, NULL),
(1, 'o_timezone', 1, '-43200|-39600|-36000|-32400|-28800|-25200|-21600|-18000|-14400|-10800|-7200|-3600|0|3600|7200|10800|14400|18000|21600|25200|28800|32400|36000|39600|43200|46800::0', 'GMT-12:00|GMT-11:00|GMT-10:00|GMT-09:00|GMT-08:00|GMT-07:00|GMT-06:00|GMT-05:00|GMT-04:00|GMT-03:00|GMT-02:00|GMT-01:00|GMT|GMT+01:00|GMT+02:00|GMT+03:00|GMT+04:00|GMT+05:00|GMT+06:00|GMT+07:00|GMT+08:00|GMT+09:00|GMT+10:00|GMT+11:00|GMT+12:00|GMT+13:00', 'enum', 3, 1, NULL),
(1, 'o_week_start', 1, '0|1|2|3|4|5|6::1', 'Sunday|Monday|Tuesday|Wednesday|Thursday|Friday|Saturday', 'enum', 3, 1, NULL),
(1, 'o_send_email', 1, 'mail|smtp::mail', 'PHP mail()|SMTP', 'enum', 4, 1, NULL),
(1, 'o_smtp_host', 1, NULL, NULL, 'string', 5, 1, NULL),
(1, 'o_smtp_pass', 1, NULL, NULL, 'string', 6, 1, NULL),
(1, 'o_smtp_port', 1, '25', NULL, 'int', 7, 1, NULL),
(1, 'o_smtp_user', 1, NULL, NULL, 'string', 8, 1, NULL),
(1, 'o_from_email', 1, NULL, NULL, 'string', 10, 1, NULL),
(1, 'o_multi_lang', 99, '1|0::0', NULL, 'enum', NULL, 0, NULL),
(1, 'o_fields_index', 99, 'd874fcc5fe73b90d770a544664a3775d', NULL, 'string', NULL, 0, NULL);

INSERT INTO `contactform_roles` (`id`, `role`, `status`) VALUES
(1, 'admin', 'T'),
(2, 'editor', 'T');

INSERT INTO `contactform_fields` (`id`, `key`, `type`, `label`, `source`, `modified`) VALUES
(1, 'addLocale', 'backend', 'Add language', 'script', NULL),
(2, 'adminForgot', 'backend', 'Forgot password', 'script', NULL),
(3, 'adminLogin', 'backend', 'Admin Login', 'script', NULL),
(4, 'backend', 'backend', 'Backend titles', 'script', NULL),
(5, 'btnAdd', 'backend', 'Button Add', 'script', NULL),
(6, 'btnBack', 'backend', 'Button Back', 'script', NULL),
(7, 'btnBackup', 'backend', 'Button Backup', 'script', NULL),
(8, 'btnCancel', 'backend', 'Button Cancel', 'script', NULL),
(9, 'btnContinue', 'backend', 'Button Continue', 'script', NULL),
(10, 'btnDelete', 'backend', 'Button Delete', 'script', NULL),
(11, 'btnLogin', 'backend', 'Login', 'script', NULL),
(12, 'btnReset', 'backend', 'Reset', 'script', NULL),
(13, 'btnSave', 'backend', 'Save', 'script', NULL),
(14, 'btnSearch', 'backend', 'Search', 'script', NULL),
(15, 'btnSend', 'backend', 'Button Send', 'script', NULL),
(16, 'btnUpdate', 'backend', 'Update', 'script', NULL),
(17, 'created', 'backend', 'Created', 'script', NULL),
(18, 'email', 'backend', 'E-Mail', 'script', NULL),
(19, 'emailForgotBody', 'backend', 'Email / Forgot Body', 'script', NULL),
(20, 'emailForgotSubject', 'backend', 'Email / Forgot Subject', 'script', NULL),
(21, 'frontend', 'backend', 'Front-end titles', 'script', NULL),
(22, 'gridActionTitle', 'backend', 'Grid / Action Title', 'script', NULL),
(23, 'gridBtnCancel', 'backend', 'Grid / Button Cancel', 'script', NULL),
(24, 'gridBtnDelete', 'backend', 'Grid / Button Delete', 'script', NULL),
(25, 'gridBtnOk', 'backend', 'Grid / Button OK', 'script', NULL),
(26, 'gridChooseAction', 'backend', 'Grid / Choose Action', 'script', NULL),
(27, 'gridConfirmationTitle', 'backend', 'Grid / Confirmation Title', 'script', NULL),
(28, 'gridDeleteConfirmation', 'backend', 'Grid / Delete confirmation', 'script', NULL),
(29, 'gridEmptyResult', 'backend', 'Grid / Empty resultset', 'script', NULL),
(30, 'gridGotoPage', 'backend', 'Grid / Go to page', 'script', NULL),
(31, 'gridItemsPerPage', 'backend', 'Grid / Items per page', 'script', NULL),
(32, 'gridNext', 'backend', 'Grid / Next', 'script', NULL),
(33, 'gridNextPage', 'backend', 'Grid / Next page', 'script', NULL),
(34, 'gridPrev', 'backend', 'Grid / Prev', 'script', NULL),
(35, 'gridPrevPage', 'backend', 'Grid / Prev page', 'script', NULL),
(36, 'gridTotalItems', 'backend', 'Grid / Total items', 'script', NULL),
(37, 'infoListingAddressBody', 'backend', 'Infobox / Listing Address Body', 'script', NULL),
(38, 'infoListingAddressTitle', 'backend', 'Infobox / Listing Address Title', 'script', NULL),
(39, 'infoListingBookingsBody', 'backend', 'Infobox / Listing Bookings Body', 'script', NULL),
(40, 'infoListingBookingsTitle', 'backend', 'Infobox / Listing Bookings Title', 'script', NULL),
(41, 'infoListingContactBody', 'backend', 'Infobox / Listing Contact Body', 'script', NULL),
(42, 'infoListingContactTitle', 'backend', 'Infobox / Listing Contact Title', 'script', NULL),
(43, 'infoListingExtendBody', 'backend', 'Infobox / Extend exp.date Body', 'script', NULL),
(44, 'infoListingExtendTitle', 'backend', 'Infobox / Extend exp.date Title', 'script', NULL),
(45, 'infoListingPricesBody', 'backend', 'Infobox / Listing Prices Body', 'script', NULL),
(46, 'infoListingPricesTitle', 'backend', 'Infobox / Listing Prices Title', 'script', NULL),
(47, 'infoLocalesArraysBody', 'backend', 'Locale / Languages Array Body', 'script', NULL),
(48, 'infoLocalesArraysTitle', 'backend', 'Locale / Languages Array Title', 'script', NULL),
(49, 'infoLocalesBackendBody', 'backend', 'Infobox / Locales Backend Body', 'script', NULL),
(50, 'infoLocalesBackendTitle', 'backend', 'Infobox / Locales Backend Title', 'script', NULL),
(51, 'infoLocalesBody', 'backend', 'Infobox / Locales Body', 'script', NULL),
(52, 'infoLocalesFrontendBody', 'backend', 'Infobox / Locales Frontend Body', 'script', NULL),
(53, 'infoLocalesFrontendTitle', 'backend', 'Infobox / Locales Frontend Title', 'script', NULL),
(54, 'infoLocalesTitle', 'backend', 'Infobox / Locales Title', 'script', NULL),
(55, 'lblAddUser', 'backend', 'Add user', 'script', NULL),
(56, 'lblBackupDatabase', 'backend', 'Backup / Database', 'script', NULL),
(57, 'lblBackupFiles', 'backend', 'Backup / Files', 'script', NULL),
(58, 'lblChoose', 'backend', 'Choose', 'script', NULL),
(59, 'lblDays', 'backend', 'Days', 'script', NULL),
(60, 'lblDelete', 'backend', 'Delete', 'script', NULL),
(61, 'lblError', 'backend', 'Error', 'script', NULL),
(62, 'lblExport', 'backend', 'Export', 'script', NULL),
(63, 'lblForgot', 'backend', 'Forgot password', 'script', NULL),
(64, 'lblIp', 'backend', 'IP address', 'script', NULL),
(65, 'lblIsActive', 'backend', 'Is Active', 'script', NULL),
(66, 'lblName', 'backend', 'Name', 'script', NULL),
(67, 'lblNo', 'backend', 'No', 'script', NULL),
(68, 'lblOption', 'backend', 'Option', 'script', NULL),
(69, 'lblOptionList', 'backend', 'Option list', 'script', NULL),
(70, 'lblRole', 'backend', 'Role', 'script', NULL),
(71, 'lblStatus', 'backend', 'Status', 'script', NULL),
(72, 'lblType', 'backend', 'Type', 'script', NULL),
(73, 'lblUpdateUser', 'backend', 'Update user', 'script', NULL),
(74, 'lblUserCreated', 'backend', 'User / Registration Date & Time', 'script', NULL),
(75, 'lblValue', 'backend', 'Value', 'script', NULL),
(76, 'lblYes', 'backend', 'Yes', 'script', NULL),
(77, 'lnkBack', 'backend', 'Link Back', 'script', NULL),
(78, 'localeArrays', 'backend', 'Locale / Arrays titles', 'script', NULL),
(79, 'locales', 'backend', 'Languages', 'script', NULL),
(80, 'locale_flag', 'backend', 'Locale / Flag', 'script', NULL),
(81, 'locale_is_default', 'backend', 'Locale / Is default', 'script', NULL),
(82, 'locale_order', 'backend', 'Locale / Order', 'script', NULL),
(83, 'locale_title', 'backend', 'Locale / Title', 'script', NULL),
(84, 'menuBackup', 'backend', 'Menu Backup', 'script', NULL),
(85, 'menuDashboard', 'backend', 'Menu Dashboard', 'script', NULL),
(86, 'menuLang', 'backend', 'Menu Multi lang', 'script', NULL),
(87, 'menuLocales', 'backend', 'Menu Languages', 'script', NULL),
(88, 'menuLogout', 'backend', 'Menu Logout', 'script', NULL),
(89, 'menuOptions', 'backend', 'Menu Options', 'script', NULL),
(90, 'menuPlugins', 'backend', 'Menu Plugins', 'script', NULL),
(91, 'menuProfile', 'backend', 'Menu Profile', 'script', NULL),
(92, 'menuUsers', 'backend', 'Menu Users', 'script', NULL),
(93, 'multilangTooltip', 'backend', 'MultiLang / Tooltip', 'script', NULL),
(94, 'opt_o_currency', 'backend', 'Options / Currency', 'script', NULL),
(95, 'opt_o_date_format', 'backend', 'Options / Date format', 'script', NULL),
(96, 'opt_o_send_email', 'backend', 'opt_o_send_email', 'script', NULL),
(97, 'opt_o_smtp_host', 'backend', 'opt_o_smtp_host', 'script', NULL),
(98, 'opt_o_smtp_pass', 'backend', 'opt_o_smtp_pass', 'script', NULL),
(99, 'opt_o_smtp_port', 'backend', 'opt_o_smtp_port', 'script', NULL),
(100, 'opt_o_smtp_user', 'backend', 'opt_o_smtp_user', 'script', NULL),
(101, 'opt_o_timezone', 'backend', 'Options / Timezone', 'script', NULL),
(102, 'opt_o_week_start', 'backend', 'Options / First day of the week', 'script', NULL),
(103, 'pass', 'backend', 'Password', 'script', NULL),
(125, 'revert_status', 'backend', 'Revert status', 'script', NULL),
(126, 'url', 'backend', 'URL', 'script', NULL),
(127, 'user', 'backend', 'Username', 'script', NULL),
(128, 'pj_email_taken', 'backend', 'Users / Email already taken', 'script', NULL),
(129, 'days_ARRAY_0', 'arrays', 'days_ARRAY_0', 'script', NULL),
(130, 'days_ARRAY_1', 'arrays', 'days_ARRAY_1', 'script', NULL),
(131, 'days_ARRAY_2', 'arrays', 'days_ARRAY_2', 'script', NULL),
(132, 'days_ARRAY_3', 'arrays', 'days_ARRAY_3', 'script', NULL),
(133, 'days_ARRAY_4', 'arrays', 'days_ARRAY_4', 'script', NULL),
(134, 'days_ARRAY_5', 'arrays', 'days_ARRAY_5', 'script', NULL),
(135, 'days_ARRAY_6', 'arrays', 'days_ARRAY_6', 'script', NULL),
(136, 'day_names_ARRAY_0', 'arrays', 'day_names_ARRAY_0', 'script', NULL),
(137, 'day_names_ARRAY_1', 'arrays', 'day_names_ARRAY_1', 'script', NULL),
(138, 'day_names_ARRAY_2', 'arrays', 'day_names_ARRAY_2', 'script', NULL),
(139, 'day_names_ARRAY_3', 'arrays', 'day_names_ARRAY_3', 'script', NULL),
(140, 'day_names_ARRAY_4', 'arrays', 'day_names_ARRAY_4', 'script', NULL),
(141, 'day_names_ARRAY_5', 'arrays', 'day_names_ARRAY_5', 'script', NULL),
(142, 'day_names_ARRAY_6', 'arrays', 'day_names_ARRAY_6', 'script', NULL),
(143, 'error_bodies_ARRAY_AA10', 'arrays', 'error_bodies_ARRAY_AA10', 'script', NULL),
(144, 'error_bodies_ARRAY_AA11', 'arrays', 'error_bodies_ARRAY_AA11', 'script', NULL),
(145, 'error_bodies_ARRAY_AA12', 'arrays', 'error_bodies_ARRAY_AA12', 'script', NULL),
(146, 'error_bodies_ARRAY_AA13', 'arrays', 'error_bodies_ARRAY_AA13', 'script', NULL),
(147, 'error_bodies_ARRAY_AB01', 'arrays', 'error_bodies_ARRAY_AB01', 'script', NULL),
(148, 'error_bodies_ARRAY_AB02', 'arrays', 'error_bodies_ARRAY_AB02', 'script', NULL),
(149, 'error_bodies_ARRAY_AB03', 'arrays', 'error_bodies_ARRAY_AB03', 'script', NULL),
(150, 'error_bodies_ARRAY_AB04', 'arrays', 'error_bodies_ARRAY_AB04', 'script', NULL),
(151, 'error_bodies_ARRAY_ALC01', 'arrays', 'error_bodies_ARRAY_ALC01', 'script', NULL),
(152, 'error_bodies_ARRAY_AO01', 'arrays', 'error_bodies_ARRAY_AO01', 'script', NULL),
(153, 'error_bodies_ARRAY_AU01', 'arrays', 'error_bodies_ARRAY_AU01', 'script', NULL),
(154, 'error_bodies_ARRAY_AU03', 'arrays', 'error_bodies_ARRAY_AU03', 'script', NULL),
(155, 'error_bodies_ARRAY_AU04', 'arrays', 'error_bodies_ARRAY_AU04', 'script', NULL),
(156, 'error_bodies_ARRAY_AU08', 'arrays', 'error_bodies_ARRAY_AU08', 'script', NULL),
(159, 'error_titles_ARRAY_AA10', 'arrays', 'error_titles_ARRAY_AA10', 'script', NULL),
(160, 'error_titles_ARRAY_AA11', 'arrays', 'error_titles_ARRAY_AA11', 'script', NULL),
(161, 'error_titles_ARRAY_AA12', 'arrays', 'error_titles_ARRAY_AA12', 'script', NULL),
(162, 'error_titles_ARRAY_AA13', 'arrays', 'error_titles_ARRAY_AA13', 'script', NULL),
(163, 'error_titles_ARRAY_AB01', 'arrays', 'error_titles_ARRAY_AB01', 'script', NULL),
(164, 'error_titles_ARRAY_AB02', 'arrays', 'error_titles_ARRAY_AB02', 'script', NULL),
(165, 'error_titles_ARRAY_AB03', 'arrays', 'error_titles_ARRAY_AB03', 'script', NULL),
(166, 'error_titles_ARRAY_AB04', 'arrays', 'error_titles_ARRAY_AB04', 'script', NULL),
(167, 'error_titles_ARRAY_AO01', 'arrays', 'error_titles_ARRAY_AO01', 'script', NULL),
(168, 'error_titles_ARRAY_AU01', 'arrays', 'error_titles_ARRAY_AU01', 'script', NULL),
(169, 'error_titles_ARRAY_AU03', 'arrays', 'error_titles_ARRAY_AU03', 'script', NULL),
(170, 'error_titles_ARRAY_AU04', 'arrays', 'error_titles_ARRAY_AU04', 'script', NULL),
(171, 'error_titles_ARRAY_AU08', 'arrays', 'error_titles_ARRAY_AU08', 'script', NULL),
(174, 'filter_ARRAY_active', 'arrays', 'filter_ARRAY_active', 'script', NULL),
(175, 'filter_ARRAY_inactive', 'arrays', 'filter_ARRAY_inactive', 'script', NULL),
(176, 'login_err_ARRAY_1', 'arrays', 'login_err_ARRAY_1', 'script', NULL),
(177, 'login_err_ARRAY_2', 'arrays', 'login_err_ARRAY_2', 'script', NULL),
(178, 'login_err_ARRAY_3', 'arrays', 'login_err_ARRAY_3', 'script', NULL),
(179, 'months_ARRAY_1', 'arrays', 'months_ARRAY_1', 'script', NULL),
(180, 'months_ARRAY_10', 'arrays', 'months_ARRAY_10', 'script', NULL),
(181, 'months_ARRAY_11', 'arrays', 'months_ARRAY_11', 'script', NULL),
(182, 'months_ARRAY_12', 'arrays', 'months_ARRAY_12', 'script', NULL),
(183, 'months_ARRAY_2', 'arrays', 'months_ARRAY_2', 'script', NULL),
(184, 'months_ARRAY_3', 'arrays', 'months_ARRAY_3', 'script', NULL),
(185, 'months_ARRAY_4', 'arrays', 'months_ARRAY_4', 'script', NULL),
(186, 'months_ARRAY_5', 'arrays', 'months_ARRAY_5', 'script', NULL),
(187, 'months_ARRAY_6', 'arrays', 'months_ARRAY_6', 'script', NULL),
(188, 'months_ARRAY_7', 'arrays', 'months_ARRAY_7', 'script', NULL),
(189, 'months_ARRAY_8', 'arrays', 'months_ARRAY_8', 'script', NULL),
(190, 'months_ARRAY_9', 'arrays', 'months_ARRAY_9', 'script', NULL),
(191, 'personal_titles_ARRAY_dr', 'arrays', 'personal_titles_ARRAY_dr', 'script', NULL),
(192, 'personal_titles_ARRAY_miss', 'arrays', 'personal_titles_ARRAY_miss', 'script', NULL),
(193, 'personal_titles_ARRAY_mr', 'arrays', 'personal_titles_ARRAY_mr', 'script', NULL),
(194, 'personal_titles_ARRAY_mrs', 'arrays', 'personal_titles_ARRAY_mrs', 'script', NULL),
(195, 'personal_titles_ARRAY_ms', 'arrays', 'personal_titles_ARRAY_ms', 'script', NULL),
(196, 'personal_titles_ARRAY_other', 'arrays', 'personal_titles_ARRAY_other', 'script', NULL),
(197, 'personal_titles_ARRAY_prof', 'arrays', 'personal_titles_ARRAY_prof', 'script', NULL),
(198, 'personal_titles_ARRAY_rev', 'arrays', 'personal_titles_ARRAY_rev', 'script', NULL),
(199, 'short_months_ARRAY_1', 'arrays', 'short_months_ARRAY_1', 'script', NULL),
(200, 'short_months_ARRAY_10', 'arrays', 'short_months_ARRAY_10', 'script', NULL),
(201, 'short_months_ARRAY_11', 'arrays', 'short_months_ARRAY_11', 'script', NULL),
(202, 'short_months_ARRAY_12', 'arrays', 'short_months_ARRAY_12', 'script', NULL),
(203, 'short_months_ARRAY_2', 'arrays', 'short_months_ARRAY_2', 'script', NULL),
(204, 'short_months_ARRAY_3', 'arrays', 'short_months_ARRAY_3', 'script', NULL),
(205, 'short_months_ARRAY_4', 'arrays', 'short_months_ARRAY_4', 'script', NULL),
(206, 'short_months_ARRAY_5', 'arrays', 'short_months_ARRAY_5', 'script', NULL),
(207, 'short_months_ARRAY_6', 'arrays', 'short_months_ARRAY_6', 'script', NULL),
(208, 'short_months_ARRAY_7', 'arrays', 'short_months_ARRAY_7', 'script', NULL),
(209, 'short_months_ARRAY_8', 'arrays', 'short_months_ARRAY_8', 'script', NULL),
(210, 'short_months_ARRAY_9', 'arrays', 'short_months_ARRAY_9', 'script', NULL),
(211, 'status_ARRAY_1', 'arrays', 'status_ARRAY_1', 'script', NULL),
(212, 'status_ARRAY_123', 'arrays', 'status_ARRAY_123', 'script', NULL),
(213, 'status_ARRAY_2', 'arrays', 'status_ARRAY_2', 'script', NULL),
(214, 'status_ARRAY_3', 'arrays', 'status_ARRAY_3', 'script', NULL),
(215, 'status_ARRAY_7', 'arrays', 'status_ARRAY_7', 'script', NULL),
(216, 'status_ARRAY_996', 'arrays', 'status_ARRAY_996', 'script', NULL),
(217, 'status_ARRAY_997', 'arrays', 'status_ARRAY_997', 'script', NULL),
(218, 'status_ARRAY_998', 'arrays', 'status_ARRAY_998', 'script', NULL),
(219, 'status_ARRAY_999', 'arrays', 'status_ARRAY_999', 'script', NULL),
(220, 'status_ARRAY_9997', 'arrays', 'status_ARRAY_9997', 'script', NULL),
(221, 'status_ARRAY_9998', 'arrays', 'status_ARRAY_9998', 'script', NULL),
(222, 'status_ARRAY_9999', 'arrays', 'status_ARRAY_9999', 'script', NULL),
(223, 'timezones_ARRAY_-10800', 'arrays', 'timezones_ARRAY_-10800', 'script', NULL),
(224, 'timezones_ARRAY_-14400', 'arrays', 'timezones_ARRAY_-14400', 'script', NULL),
(225, 'timezones_ARRAY_-18000', 'arrays', 'timezones_ARRAY_-18000', 'script', NULL),
(226, 'timezones_ARRAY_-21600', 'arrays', 'timezones_ARRAY_-21600', 'script', NULL),
(227, 'timezones_ARRAY_-25200', 'arrays', 'timezones_ARRAY_-25200', 'script', NULL),
(228, 'timezones_ARRAY_-28800', 'arrays', 'timezones_ARRAY_-28800', 'script', NULL),
(229, 'timezones_ARRAY_-32400', 'arrays', 'timezones_ARRAY_-32400', 'script', NULL),
(230, 'timezones_ARRAY_-3600', 'arrays', 'timezones_ARRAY_-3600', 'script', NULL),
(231, 'timezones_ARRAY_-36000', 'arrays', 'timezones_ARRAY_-36000', 'script', NULL),
(232, 'timezones_ARRAY_-39600', 'arrays', 'timezones_ARRAY_-39600', 'script', NULL),
(233, 'timezones_ARRAY_-43200', 'arrays', 'timezones_ARRAY_-43200', 'script', NULL),
(234, 'timezones_ARRAY_-7200', 'arrays', 'timezones_ARRAY_-7200', 'script', NULL),
(235, 'timezones_ARRAY_0', 'arrays', 'timezones_ARRAY_0', 'script', NULL),
(236, 'timezones_ARRAY_10800', 'arrays', 'timezones_ARRAY_10800', 'script', NULL),
(237, 'timezones_ARRAY_14400', 'arrays', 'timezones_ARRAY_14400', 'script', NULL),
(238, 'timezones_ARRAY_18000', 'arrays', 'timezones_ARRAY_18000', 'script', NULL),
(239, 'timezones_ARRAY_21600', 'arrays', 'timezones_ARRAY_21600', 'script', NULL),
(240, 'timezones_ARRAY_25200', 'arrays', 'timezones_ARRAY_25200', 'script', NULL),
(241, 'timezones_ARRAY_28800', 'arrays', 'timezones_ARRAY_28800', 'script', NULL),
(242, 'timezones_ARRAY_32400', 'arrays', 'timezones_ARRAY_32400', 'script', NULL),
(243, 'timezones_ARRAY_3600', 'arrays', 'timezones_ARRAY_3600', 'script', NULL),
(244, 'timezones_ARRAY_36000', 'arrays', 'timezones_ARRAY_36000', 'script', NULL),
(245, 'timezones_ARRAY_39600', 'arrays', 'timezones_ARRAY_39600', 'script', NULL),
(246, 'timezones_ARRAY_43200', 'arrays', 'timezones_ARRAY_43200', 'script', NULL),
(247, 'timezones_ARRAY_46800', 'arrays', 'timezones_ARRAY_46800', 'script', NULL),
(248, 'timezones_ARRAY_7200', 'arrays', 'timezones_ARRAY_7200', 'script', NULL),
(249, 'u_statarr_ARRAY_F', 'arrays', 'u_statarr_ARRAY_F', 'script', NULL),
(250, 'u_statarr_ARRAY_T', 'arrays', 'u_statarr_ARRAY_T', 'script', NULL),
(251, '_yesno_ARRAY_F', 'arrays', '_yesno_ARRAY_F', 'script', NULL),
(252, '_yesno_ARRAY_T', 'arrays', '_yesno_ARRAY_T', 'script', NULL),
(278, 'menuForms', 'backend', 'Menu / Forms', 'script', NULL),
(279, 'lblCreateForm', 'backend', 'Label / Create form', 'script', NULL),
(280, 'lblFormName', 'backend', 'Label / Form name', 'script', NULL),
(281, 'lblAll', 'backend', 'Label / All', 'script', NULL),
(282, 'lblActive', 'backend', 'Label / Active', 'script', NULL),
(283, 'lblInActive', 'backend', 'Label / Inactive', 'script', NULL),
(284, 'delete_selected', 'backend', 'Label / Delete selected', 'script', NULL),
(285, 'delete_confirmation', 'backend', 'Label / Delete confirmation', 'script', NULL),
(286, 'lblFormDetails', 'backend', 'Label / Form details', 'script', NULL),
(287, 'lblFormFields', 'backend', 'Label / Form fields', 'script', NULL),
(288, 'lblInstall', 'backend', 'Label / Install', 'script', NULL),
(289, 'error_titles_ARRAY_AF01', 'arrays', 'error_titles_ARRAY_AF01', 'script', NULL),
(290, 'error_titles_ARRAY_AF03', 'arrays', 'error_titles_ARRAY_AF03', 'script', NULL),
(291, 'error_titles_ARRAY_AF04', 'arrays', 'error_titles_ARRAY_AF04', 'script', NULL),
(292, 'error_titles_ARRAY_AF08', 'arrays', 'error_titles_ARRAY_AF08', 'script', NULL),
(293, 'error_bodies_ARRAY_AF01', 'arrays', 'error_bodies_ARRAY_AF01', 'script', NULL),
(294, 'error_bodies_ARRAY_AF03', 'arrays', 'error_bodies_ARRAY_AF03', 'script', NULL),
(295, 'error_bodies_ARRAY_AF04', 'arrays', 'error_bodies_ARRAY_AF04', 'script', NULL),
(296, 'error_bodies_ARRAY_AF08', 'arrays', 'error_bodies_ARRAY_AF08', 'script', NULL),
(297, 'lblFormWidth', 'backend', 'Label / Form width', 'script', NULL),
(298, 'lblPixels', 'backend', 'Label / pixels', 'script', NULL),
(299, 'lblLabelWidth', 'backend', 'Label / Label width', 'script', NULL),
(300, 'lblLabelPosition', 'backend', 'Label / Label position', 'script', NULL),
(301, 'label_position_ARRAY_right', 'arrays', 'label_position_ARRAY_right', 'script', NULL),
(302, 'label_position_ARRAY_left', 'arrays', 'label_position_ARRAY_left', 'script', NULL),
(303, 'label_position_ARRAY_top', 'arrays', 'label_position_ARRAY_top', 'script', NULL),
(304, 'lblSubmitButton', 'backend', 'Label / Submit button', 'script', NULL),
(305, 'lblDateFormat', 'backend', 'Label / Date format', 'script', NULL),
(306, 'lblCaptchaEnabled', 'backend', 'Label / Captcha enable', 'script', NULL),
(332, 'lblEmailFormat', 'backend', 'Label / Email format', 'script', NULL),
(333, 'email_format_ARRAY_text', 'arrays', 'email_format_ARRAY_text', 'script', NULL),
(334, 'email_format_ARRAY_html', 'arrays', 'email_format_ARRAY_html', 'script', NULL),
(335, 'lblMailerType', 'backend', 'Label / Mailer type', 'script', NULL),
(336, 'mailer_type_ARRAY_php', 'arrays', 'mailer_type_ARRAY_php', 'script', NULL),
(337, 'mailer_type_ARRAY_smtp', 'arrays', 'mailer_type_ARRAY_smtp', 'script', NULL),
(338, 'lblConfirmationOptions', 'backend', 'Label / Confirmation options', 'script', NULL),
(339, 'lblConfirmationMessage', 'backend', 'Label / Confirmation message', 'script', NULL),
(340, 'lblRedirectURL', 'backend', 'Label / Redirect URL', 'script', NULL),
(341, 'confirm_options_ARRAY_message', 'arrays', 'confirm_options_ARRAY_message', 'script', NULL),
(342, 'confirm_options_ARRAY_redirect', 'arrays', 'confirm_options_ARRAY_redirect', 'script', NULL),
(343, 'lblSendTo', 'backend', 'Label / Send to', 'script', NULL),
(344, 'lblEmailSubject', 'backend', 'Label / Email subject', 'script', NULL),
(345, 'lblFormStyles', 'backend', 'Label / Form styles', 'script', NULL),
(346, 'lblAutoResponder', 'backend', 'Label / Auto responder', 'script', NULL),
(347, 'lblSubmitButtonTip', 'backend', 'Tips / submit button', 'script', NULL),
(348, 'lblDateFormatTip', 'backend', 'Tips / Date format', 'script', NULL),
(349, 'lblCaptchaTip', 'backend', 'Tips / Captcha enable', 'script', NULL),
(350, 'lblSendToTip', 'backend', 'Tips / send to tip', 'script', NULL),
(351, 'lblEmailSubjectTip', 'backend', 'Tips / Email subject tip', 'script', NULL),
(352, 'lblMailerTypeTip', 'backend', 'Tips / mailer type tip', 'script', NULL),
(353, 'lblEmailFormatTip', 'backend', 'Tips / email format tip', 'script', NULL),
(354, 'lblConfirmationOptionsTip', 'backend', 'Tips / confirmation options tip', 'script', NULL),
(355, 'infoAutoResponseTitle', 'backend', 'Infobox / Auto responder settings', 'script', NULL),
(356, 'infoAutoResponseBody', 'backend', 'Infobox / Auto responder body', 'script', NULL),
(357, 'lblAutoSubject', 'backend', 'Label / auto subject', 'script', NULL),
(358, 'lblAutoMessage', 'backend', 'Label / auto message', 'script', NULL),
(359, 'lblFontFamily', 'backend', 'Label / Font family', 'script', NULL),
(360, 'lblFontSize', 'backend', 'Label / Font size', 'script', NULL),
(361, 'lblFontColor', 'backend', 'Label / Font color', 'script', NULL),
(362, 'lblBackgroundColor', 'backend', 'Label / Background color', 'script', NULL),
(363, 'lblAddNewField', 'backend', 'Label / Add new field', 'script', NULL),
(364, 'lblEditField', 'backend', 'Label / Edit field', 'script', NULL),
(365, 'lblMediumHeading', 'backend', 'Label / Medium heading text', 'script', NULL),
(366, 'lblLargeHeading', 'backend', 'Label / Large heading text', 'script', NULL),
(367, 'lblSmallHeading', 'backend', 'Label / Smallheading text', 'script', NULL),
(393, 'lblFieldLabel', 'backend', 'Label / Field label', 'script', NULL),
(394, 'lblHeadingSize', 'backend', 'Label / Heading size', 'script', NULL),
(395, 'heading_size_ARRAY_small', 'arrays', 'heading_size_ARRAY_small', 'script', NULL),
(396, 'heading_size_ARRAY_medium', 'arrays', 'heading_size_ARRAY_medium', 'script', NULL),
(397, 'heading_size_ARRAY_large', 'arrays', 'heading_size_ARRAY_large', 'script', NULL),
(398, 'lblHeadingText', 'backend', 'Label / Heading text', 'script', NULL),
(399, 'lblLabel', 'backend', 'Label / Label', 'script', NULL),
(400, 'lblRequired', 'backend', 'Label / Required', 'script', NULL),
(401, 'lblDefaultValue', 'backend', 'Label / Default value', 'script', NULL),
(402, 'lblHintText', 'backend', 'Label / Hint text', 'script', NULL),
(403, 'lblSize', 'backend', 'Label / Size', 'script', NULL),
(404, 'lblMaxLength', 'backend', 'Label / Max length', 'script', NULL),
(405, 'lblValidation', 'backend', 'Label / Validation', 'script', NULL),
(406, 'validations_ARRAY_none', 'arrays', 'validations_ARRAY_none', 'script', NULL),
(408, 'validations_ARRAY_url', 'arrays', 'validations_ARRAY_url', 'script', NULL),
(409, 'validations_ARRAY_numeric', 'arrays', 'validations_ARRAY_numeric', 'script', NULL),
(410, 'validations_ARRAY_alphabetic', 'arrays', 'validations_ARRAY_alphabetic', 'script', NULL),
(411, 'validations_ARRAY_alphanumeric', 'arrays', 'validations_ARRAY_alphanumeric', 'script', NULL),
(412, 'lblColumns', 'backend', 'Label / Columns', 'script', NULL),
(413, 'lblRows', 'backend', 'Label / Rows', 'script', NULL),
(414, 'lblOptionData', 'backend', 'Label / Option data', 'script', NULL),
(415, 'default_options_ARRAY_option_1', 'arrays', 'default_options_ARRAY_option_1', 'script', NULL),
(416, 'default_options_ARRAY_option_2', 'arrays', 'default_options_ARRAY_option_2', 'script', NULL),
(417, 'default_options_ARRAY_option_3', 'arrays', 'default_options_ARRAY_option_3', 'script', NULL),
(418, 'lblMaxFileSize', 'backend', 'Label / Max file size', 'script', NULL),
(419, 'lblExtensions', 'backend', 'Label / Extensions', 'script', NULL),
(420, 'lblAllowMultiple', 'backend', 'Label / Allow multiple', 'script', NULL),
(421, 'lblDefaultExtensions', 'backend', 'Label / Default extensions', 'script', NULL),
(422, 'btnSubmit', 'backend', 'Button / Submit', 'script', NULL),
(423, 'lblDeleteField', 'backend', 'Label / Delete field', 'script', NULL),
(424, 'lblDeleteFieldConfirm', 'backend', 'Label / Delete field confirm', 'script', NULL),
(450, 'lblJSInstallCode', 'backend', 'Label / Javascript installation code', 'script', NULL),
(451, 'infoJSInstallBody', 'backend', 'Infobox / javascript install body', 'script', NULL),
(452, 'lblToolboxText', 'backend', 'Label / Toolbox text', 'script', NULL),
(453, 'infoFormDetailTitle', 'backend', 'Infobox / Form details title', 'script', NULL),
(454, 'infoFormDetailBody', 'backend', 'Infobox / Form details body', 'script', NULL),
(455, 'infoFormStylesTitle', 'backend', 'Infobox / Form styles title', 'script', NULL),
(456, 'infoFormStylesBody', 'backend', 'Infobox / Form styles body', 'script', NULL),
(457, 'btnPreviewForm', 'backend', 'Button / Preview form', 'script', NULL),
(458, 'lblRequiredErrorMessage', 'backend', 'Label / Required error message', 'script', NULL),
(459, 'lblValidationErrorMessage', 'backend', 'Label / Validation error message', 'script', NULL),
(460, 'lblMaxsizeErrorMessage', 'backend', 'Label / Max file size error message', 'script', NULL),
(461, 'lblExtensionErrorMessage', 'backend', 'Label / Extension error message', 'script', NULL),
(462, 'lblEmailErrorMessage', 'backend', 'Label / Email error message', 'script', NULL),
(463, 'lblCaptchaRequiredMessage', 'backend', 'Label / Captcha required message', 'script', NULL),
(464, 'lblCaptchaRequiredMessageTip', 'backend', 'Label / Required captcha tip', 'script', NULL),
(465, 'lblCaptchaIncorrectMessage', 'backend', 'Label / Incorrect captcha message', 'script', NULL),
(466, 'lblCaptchaIncorrectMessageTip', 'backend', 'Label / Incorrect captcha tip', 'script', NULL),
(467, 'opt_o_time_format', 'backend', 'Options / Time format', 'script', NULL),
(468, 'lblSubmissions', 'backend', 'Label / Submissions', 'script', NULL),
(469, 'lblRequiredField', 'backend', 'Label / This field is required.', 'script', NULL),
(470, 'lblFormHint', 'backend', 'Label / Form hint', 'script', NULL),
(496, 'lblHTMLCode', 'backend', 'Label / HTML installation code', 'script', NULL),
(497, 'infoHTMLInstallBody', 'backend', 'Infobox / HMLT installation body', 'script', NULL),
(499, 'lblSubmission', 'backend', 'Label / Submission', 'script', NULL),
(500, 'lblForms', 'backend', 'Label / Forms', 'script', NULL),
(501, 'lblForm', 'backend', 'Label / Form', 'script', NULL),
(502, 'lblUsers', 'backend', 'Label / Users', 'script', NULL),
(503, 'lblUser', 'backend', 'Label / User', 'script', NULL),
(504, 'lblLastSubmissions', 'backend', 'Label / Last Submissions', 'script', NULL),
(505, 'lblMostPopularForms', 'backend', 'Label / Most Popular Forms', 'script', NULL),
(506, 'lblLastLoggedUsers', 'backend', 'Label / Last Logged in Users', 'script', NULL),
(507, 'lblSubmissionNotFound', 'backend', 'Label / There is no submission found.', 'script', NULL),
(508, 'lblFormNotFound', 'backend', 'Label / There is no form found.', 'script', NULL),
(509, 'lblUserNotFound', 'backend', 'Label / There is no user found.', 'script', NULL),
(510, 'lblDashLastLogin', 'backend', 'Label / Last login', 'script', NULL),
(511, 'infoFormFieldTitle', 'backend', 'Infobox / Form fields info title', 'script', NULL),
(512, 'infoFormFieldBody', 'backend', 'Infobox / Form fields info text', 'script', NULL),
(538, 'infoFormsTitle', 'backend', 'Infobox / Form list title', 'script', NULL),
(539, 'infoFormsBody', 'backend', 'Infobox / Forms list body', 'script', NULL),
(540, 'infoAddFormTitle', 'backend', 'Infobox / Add new form', 'script', NULL),
(541, 'infoAddFormBody', 'backend', 'Infobox / Add new form body', 'script', NULL),
(542, 'infoSubmissionTitle', 'backend', 'Infobox / Submission title', 'script', NULL),
(543, 'infoSubmissionBody', 'backend', 'Infobox / Submission body', 'script', NULL),
(569, 'lblCaptchaType', 'backend', 'Label / Captcha type', 'script', NULL),
(570, 'captcha_types_ARRAY_string', 'arrays', 'captcha_types_ARRAY_string', 'script', NULL),
(571, 'captcha_types_ARRAY_math', 'arrays', 'captcha_types_ARRAY_math', 'script', NULL),
(572, 'lblRejectLinks', 'backend', 'Label / Reject links', 'script', NULL),
(573, 'lblRejectLinksTip', 'backend', 'Label / Reject links tip', 'script', NULL),
(574, 'lblBlockWords', 'backend', 'Label / Block words', 'script', NULL),
(575, 'lblBlockWordsTip', 'backend', 'Label / Block words tip', 'script', NULL),
(576, 'label_data_blocked', 'frontend', 'Label / Data blocked', 'script', NULL),
(577, 'lblInvalidUrl', 'backend', 'Label / Invalid url', 'script', NULL),
(578, 'lblSendConfirmation', 'backend', 'Label / Send confirmation', 'script', NULL),
(579, 'lblFieldBackgroundColor', 'backend', 'Label / Field background color', 'script', NULL);

INSERT INTO `contactform_multi_lang` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`) VALUES
(NULL, 1, 'pjField', 1, 'title', 'Add language', 'script'),
(NULL, 2, 'pjField', 1, 'title', 'Password reminder', 'script'),
(NULL, 3, 'pjField', 1, 'title', 'Admin Login', 'script'),
(NULL, 4, 'pjField', 1, 'title', 'Back-end titles', 'script'),
(NULL, 5, 'pjField', 1, 'title', 'Add +', 'script'),
(NULL, 6, 'pjField', 1, 'title', '« Back', 'script'),
(NULL, 7, 'pjField', 1, 'title', 'Backup', 'script'),
(NULL, 8, 'pjField', 1, 'title', 'Cancel', 'script'),
(NULL, 9, 'pjField', 1, 'title', 'Continue', 'script'),
(NULL, 10, 'pjField', 1, 'title', 'Delete', 'script'),
(NULL, 11, 'pjField', 1, 'title', 'Login', 'script'),
(NULL, 12, 'pjField', 1, 'title', 'Reset', 'script'),
(NULL, 13, 'pjField', 1, 'title', 'Save', 'script'),
(NULL, 14, 'pjField', 1, 'title', 'Search', 'script'),
(NULL, 15, 'pjField', 1, 'title', 'Send', 'script'),
(NULL, 16, 'pjField', 1, 'title', 'Update', 'script'),
(NULL, 17, 'pjField', 1, 'title', 'DateTime', 'script'),
(NULL, 18, 'pjField', 1, 'title', 'Email', 'script'),
(NULL, 19, 'pjField', 1, 'title', 'Dear {Name},Your password: {Password}', 'script'),
(NULL, 20, 'pjField', 1, 'title', 'Password reminder', 'script'),
(NULL, 21, 'pjField', 1, 'title', 'Front-end titles', 'script'),
(NULL, 22, 'pjField', 1, 'title', 'Action confirmation', 'script'),
(NULL, 23, 'pjField', 1, 'title', 'Cancel', 'script'),
(NULL, 24, 'pjField', 1, 'title', 'Delete', 'script'),
(NULL, 25, 'pjField', 1, 'title', 'OK', 'script'),
(NULL, 26, 'pjField', 1, 'title', 'Choose Action', 'script'),
(NULL, 27, 'pjField', 1, 'title', 'Are you sure you want to delete selected record?', 'script'),
(NULL, 28, 'pjField', 1, 'title', 'Delete confirmation', 'script'),
(NULL, 29, 'pjField', 1, 'title', 'No records found', 'script'),
(NULL, 30, 'pjField', 1, 'title', 'Go to page:', 'script'),
(NULL, 31, 'pjField', 1, 'title', 'Items per page', 'script'),
(NULL, 32, 'pjField', 1, 'title', 'Next »', 'script'),
(NULL, 33, 'pjField', 1, 'title', 'Next page', 'script'),
(NULL, 34, 'pjField', 1, 'title', '« Prev', 'script'),
(NULL, 35, 'pjField', 1, 'title', 'Prev page', 'script'),
(NULL, 36, 'pjField', 1, 'title', 'Total items:', 'script'),
(NULL, 37, 'pjField', 1, 'title', 'You can show a map with the location of the listing accommodation on the listing details page. Submit the full address first and then click on ''Get coordinates from Google Maps API'' button. Save your data.', 'script'),
(NULL, 38, 'pjField', 1, 'title', 'Location and address', 'script'),
(NULL, 39, 'pjField', 1, 'title', 'Listing Bookings Body', 'script'),
(NULL, 40, 'pjField', 1, 'title', 'Listing Bookings Title', 'script'),
(NULL, 41, 'pjField', 1, 'title', 'Listing Contact Body', 'script'),
(NULL, 42, 'pjField', 1, 'title', 'Listing Contact Title', 'script'),
(NULL, 43, 'pjField', 1, 'title', 'Extend exp.date Body', 'script'),
(NULL, 44, 'pjField', 1, 'title', 'Extend exp.date Title', 'script'),
(NULL, 45, 'pjField', 1, 'title', 'Listing Prices Body', 'script'),
(NULL, 46, 'pjField', 1, 'title', 'Listing Prices Title', 'script'),
(NULL, 47, 'pjField', 1, 'title', 'Languages Array Body', 'script'),
(NULL, 48, 'pjField', 1, 'title', 'Languages Arrays Title', 'script'),
(NULL, 49, 'pjField', 1, 'title', 'Languages Backend Body', 'script'),
(NULL, 50, 'pjField', 1, 'title', 'Languages Backend Title', 'script'),
(NULL, 51, 'pjField', 1, 'title', 'Languages Body', 'script'),
(NULL, 52, 'pjField', 1, 'title', 'Languages Frontend Body', 'script'),
(NULL, 53, 'pjField', 1, 'title', 'Languages Frontend Title', 'script'),
(NULL, 54, 'pjField', 1, 'title', 'Languages Title', 'script'),
(NULL, 55, 'pjField', 1, 'title', 'Add user', 'script'),
(NULL, 56, 'pjField', 1, 'title', 'Backup database', 'script'),
(NULL, 57, 'pjField', 1, 'title', 'Backup files', 'script'),
(NULL, 58, 'pjField', 1, 'title', 'Choose', 'script'),
(NULL, 59, 'pjField', 1, 'title', 'days', 'script'),
(NULL, 60, 'pjField', 1, 'title', 'Delete', 'script'),
(NULL, 61, 'pjField', 1, 'title', 'Error', 'script'),
(NULL, 62, 'pjField', 1, 'title', 'Export', 'script'),
(NULL, 63, 'pjField', 1, 'title', 'Forgot password', 'script'),
(NULL, 64, 'pjField', 1, 'title', 'IP address', 'script'),
(NULL, 65, 'pjField', 1, 'title', 'Is confirmed', 'script'),
(NULL, 66, 'pjField', 1, 'title', 'Name', 'script'),
(NULL, 67, 'pjField', 1, 'title', 'No', 'script'),
(NULL, 68, 'pjField', 1, 'title', 'Option', 'script'),
(NULL, 69, 'pjField', 1, 'title', 'Option list', 'script'),
(NULL, 70, 'pjField', 1, 'title', 'Role', 'script'),
(NULL, 71, 'pjField', 1, 'title', 'Status', 'script'),
(NULL, 72, 'pjField', 1, 'title', 'Type', 'script'),
(NULL, 73, 'pjField', 1, 'title', 'Update user', 'script'),
(NULL, 74, 'pjField', 1, 'title', 'Registration date/time', 'script'),
(NULL, 75, 'pjField', 1, 'title', 'Value', 'script'),
(NULL, 76, 'pjField', 1, 'title', 'Yes', 'script'),
(NULL, 77, 'pjField', 1, 'title', 'Back', 'script'),
(NULL, 78, 'pjField', 1, 'title', 'Arrays titles', 'script'),
(NULL, 79, 'pjField', 1, 'title', 'Languages', 'script'),
(NULL, 80, 'pjField', 1, 'title', 'Flag', 'script'),
(NULL, 81, 'pjField', 1, 'title', 'Is default', 'script'),
(NULL, 82, 'pjField', 1, 'title', 'Order', 'script'),
(NULL, 83, 'pjField', 1, 'title', 'Title', 'script'),
(NULL, 84, 'pjField', 1, 'title', 'Backup', 'script'),
(NULL, 85, 'pjField', 1, 'title', 'Dashboard', 'script'),
(NULL, 86, 'pjField', 1, 'title', 'Multi Lang', 'script'),
(NULL, 87, 'pjField', 1, 'title', 'Languages', 'script'),
(NULL, 88, 'pjField', 1, 'title', 'Logout', 'script'),
(NULL, 89, 'pjField', 1, 'title', 'Options', 'script'),
(NULL, 90, 'pjField', 1, 'title', 'Plugins', 'script'),
(NULL, 91, 'pjField', 1, 'title', 'Profile', 'script'),
(NULL, 92, 'pjField', 1, 'title', 'Users', 'script'),
(NULL, 93, 'pjField', 1, 'title', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', 'script'),
(NULL, 94, 'pjField', 1, 'title', 'Currency', 'script'),
(NULL, 95, 'pjField', 1, 'title', 'Date format', 'script'),
(NULL, 96, 'pjField', 1, 'title', 'Send email', 'script'),
(NULL, 97, 'pjField', 1, 'title', 'SMTP Host', 'script'),
(NULL, 98, 'pjField', 1, 'title', 'SMTP Password', 'script'),
(NULL, 99, 'pjField', 1, 'title', 'SMTP Port', 'script'),
(NULL, 100, 'pjField', 1, 'title', 'SMTP Username', 'script'),
(NULL, 101, 'pjField', 1, 'title', 'Timezone', 'script'),
(NULL, 102, 'pjField', 1, 'title', 'First day of the week', 'script'),
(NULL, 103, 'pjField', 1, 'title', 'Password', 'script'),
(NULL, 125, 'pjField', 1, 'title', 'Revert status', 'script'),
(NULL, 126, 'pjField', 1, 'title', 'URL', 'script'),
(NULL, 127, 'pjField', 1, 'title', 'Username', 'script'),
(NULL, 128, 'pjField', 1, 'title', 'Email address was already in use', 'script'),
(NULL, 129, 'pjField', 1, 'title', 'Sunday', 'script'),
(NULL, 130, 'pjField', 1, 'title', 'Monday', 'script'),
(NULL, 131, 'pjField', 1, 'title', 'Tuesday', 'script'),
(NULL, 132, 'pjField', 1, 'title', 'Wednesday', 'script'),
(NULL, 133, 'pjField', 1, 'title', 'Thursday', 'script'),
(NULL, 134, 'pjField', 1, 'title', 'Friday', 'script'),
(NULL, 135, 'pjField', 1, 'title', 'Saturday', 'script'),
(NULL, 136, 'pjField', 1, 'title', 'S', 'script'),
(NULL, 137, 'pjField', 1, 'title', 'M', 'script'),
(NULL, 138, 'pjField', 1, 'title', 'T', 'script'),
(NULL, 139, 'pjField', 1, 'title', 'W', 'script'),
(NULL, 140, 'pjField', 1, 'title', 'T', 'script'),
(NULL, 141, 'pjField', 1, 'title', 'F', 'script'),
(NULL, 142, 'pjField', 1, 'title', 'S', 'script'),
(NULL, 143, 'pjField', 1, 'title', 'Given email address is not associated with any account.', 'script'),
(NULL, 144, 'pjField', 1, 'title', 'For further instructions please check your mailbox.', 'script'),
(NULL, 145, 'pjField', 1, 'title', 'We are sorry, please try again later.', 'script'),
(NULL, 146, 'pjField', 1, 'title', 'All the changes made to your profile have been saved.', 'script'),
(NULL, 147, 'pjField', 1, 'title', 'To protect your system from loses perform a backup anytime you wish. Click on the generated file link to download the backup file.', 'script'),
(NULL, 148, 'pjField', 1, 'title', 'All backup files have been saved.', 'script'),
(NULL, 149, 'pjField', 1, 'title', 'No option was selected.', 'script'),
(NULL, 150, 'pjField', 1, 'title', 'Backup not performed.', 'script'),
(NULL, 151, 'pjField', 1, 'title', 'All the changes made to titles have been saved.', 'script'),
(NULL, 152, 'pjField', 1, 'title', 'All the changes made to options have been saved.', 'script'),
(NULL, 153, 'pjField', 1, 'title', 'All the changes made to this user have been saved.', 'script'),
(NULL, 154, 'pjField', 1, 'title', 'All the changes made to this user have been saved.', 'script'),
(NULL, 155, 'pjField', 1, 'title', 'We are sorry, but the user has not been added.', 'script'),
(NULL, 156, 'pjField', 1, 'title', 'User your looking for is missing.', 'script'),
(NULL, 159, 'pjField', 1, 'title', 'Account not found!', 'script'),
(NULL, 160, 'pjField', 1, 'title', 'Password send!', 'script'),
(NULL, 161, 'pjField', 1, 'title', 'Password not send!', 'script'),
(NULL, 162, 'pjField', 1, 'title', 'Profile updated!', 'script'),
(NULL, 163, 'pjField', 1, 'title', 'Backup', 'script'),
(NULL, 164, 'pjField', 1, 'title', 'Backup complete!', 'script'),
(NULL, 165, 'pjField', 1, 'title', 'Backup failed!', 'script'),
(NULL, 166, 'pjField', 1, 'title', 'Backup failed!', 'script'),
(NULL, 167, 'pjField', 1, 'title', 'Options updated!', 'script'),
(NULL, 168, 'pjField', 1, 'title', 'User updated!', 'script'),
(NULL, 169, 'pjField', 1, 'title', 'User added!', 'script'),
(NULL, 170, 'pjField', 1, 'title', 'User failed to add.', 'script'),
(NULL, 171, 'pjField', 1, 'title', 'User not found.', 'script'),
(NULL, 174, 'pjField', 1, 'title', 'Active', 'script'),
(NULL, 175, 'pjField', 1, 'title', 'Inactive', 'script'),
(NULL, 176, 'pjField', 1, 'title', 'Wrong username or password', 'script'),
(NULL, 177, 'pjField', 1, 'title', 'Access denied', 'script'),
(NULL, 178, 'pjField', 1, 'title', 'Account is disabled', 'script'),
(NULL, 179, 'pjField', 1, 'title', 'January', 'script'),
(NULL, 180, 'pjField', 1, 'title', 'October', 'script'),
(NULL, 181, 'pjField', 1, 'title', 'November', 'script'),
(NULL, 182, 'pjField', 1, 'title', 'December', 'script'),
(NULL, 183, 'pjField', 1, 'title', 'February', 'script'),
(NULL, 184, 'pjField', 1, 'title', 'March', 'script'),
(NULL, 185, 'pjField', 1, 'title', 'April', 'script'),
(NULL, 186, 'pjField', 1, 'title', 'May', 'script'),
(NULL, 187, 'pjField', 1, 'title', 'June', 'script'),
(NULL, 188, 'pjField', 1, 'title', 'July', 'script'),
(NULL, 189, 'pjField', 1, 'title', 'August', 'script'),
(NULL, 190, 'pjField', 1, 'title', 'September', 'script'),
(NULL, 191, 'pjField', 1, 'title', 'Dr.', 'script'),
(NULL, 192, 'pjField', 1, 'title', 'Miss', 'script'),
(NULL, 193, 'pjField', 1, 'title', 'Mr.', 'script'),
(NULL, 194, 'pjField', 1, 'title', 'Mrs.', 'script'),
(NULL, 195, 'pjField', 1, 'title', 'Ms.', 'script'),
(NULL, 196, 'pjField', 1, 'title', 'Other', 'script'),
(NULL, 197, 'pjField', 1, 'title', 'Prof.', 'script'),
(NULL, 198, 'pjField', 1, 'title', 'Rev.', 'script'),
(NULL, 199, 'pjField', 1, 'title', 'Jan', 'script'),
(NULL, 200, 'pjField', 1, 'title', 'Oct', 'script'),
(NULL, 201, 'pjField', 1, 'title', 'Nov', 'script'),
(NULL, 202, 'pjField', 1, 'title', 'Dec', 'script'),
(NULL, 203, 'pjField', 1, 'title', 'Feb', 'script'),
(NULL, 204, 'pjField', 1, 'title', 'Mar', 'script'),
(NULL, 205, 'pjField', 1, 'title', 'Apr', 'script'),
(NULL, 206, 'pjField', 1, 'title', 'May', 'script'),
(NULL, 207, 'pjField', 1, 'title', 'Jun', 'script'),
(NULL, 208, 'pjField', 1, 'title', 'Jul', 'script'),
(NULL, 209, 'pjField', 1, 'title', 'Aug', 'script'),
(NULL, 210, 'pjField', 1, 'title', 'Sep', 'script'),
(NULL, 211, 'pjField', 1, 'title', 'You are not loged in.', 'script'),
(NULL, 212, 'pjField', 1, 'title', 'Your hosting account does not allow uploading such a large image.', 'script'),
(NULL, 213, 'pjField', 1, 'title', 'Access denied. You have not requisite rights to.', 'script'),
(NULL, 214, 'pjField', 1, 'title', 'Empty resultset.', 'script'),
(NULL, 215, 'pjField', 1, 'title', 'The operation is not allowed in demo mode.', 'script'),
(NULL, 216, 'pjField', 1, 'title', 'No property for the reservation found', 'script'),
(NULL, 217, 'pjField', 1, 'title', 'No reservation found', 'script'),
(NULL, 218, 'pjField', 1, 'title', 'No permisions to edit the reservation', 'script'),
(NULL, 219, 'pjField', 1, 'title', 'No permisions to edit the property', 'script'),
(NULL, 220, 'pjField', 1, 'title', 'E-Mail address already exist', 'script'),
(NULL, 221, 'pjField', 1, 'title', 'Your registration was successfull. Your account needs to be approved.', 'script'),
(NULL, 222, 'pjField', 1, 'title', 'Your registration was successfull.', 'script'),
(NULL, 223, 'pjField', 1, 'title', 'GMT-03:00', 'script'),
(NULL, 224, 'pjField', 1, 'title', 'GMT-04:00', 'script'),
(NULL, 225, 'pjField', 1, 'title', 'GMT-05:00', 'script'),
(NULL, 226, 'pjField', 1, 'title', 'GMT-06:00', 'script'),
(NULL, 227, 'pjField', 1, 'title', 'GMT-07:00', 'script'),
(NULL, 228, 'pjField', 1, 'title', 'GMT-08:00', 'script'),
(NULL, 229, 'pjField', 1, 'title', 'GMT-09:00', 'script'),
(NULL, 230, 'pjField', 1, 'title', 'GMT-01:00', 'script'),
(NULL, 231, 'pjField', 1, 'title', 'GMT-10:00', 'script'),
(NULL, 232, 'pjField', 1, 'title', 'GMT-11:00', 'script'),
(NULL, 233, 'pjField', 1, 'title', 'GMT-12:00', 'script'),
(NULL, 234, 'pjField', 1, 'title', 'GMT-02:00', 'script'),
(NULL, 235, 'pjField', 1, 'title', 'GMT', 'script'),
(NULL, 236, 'pjField', 1, 'title', 'GMT+03:00', 'script'),
(NULL, 237, 'pjField', 1, 'title', 'GMT+04:00', 'script'),
(NULL, 238, 'pjField', 1, 'title', 'GMT+05:00', 'script'),
(NULL, 239, 'pjField', 1, 'title', 'GMT+06:00', 'script'),
(NULL, 240, 'pjField', 1, 'title', 'GMT+07:00', 'script'),
(NULL, 241, 'pjField', 1, 'title', 'GMT+08:00', 'script'),
(NULL, 242, 'pjField', 1, 'title', 'GMT+09:00', 'script'),
(NULL, 243, 'pjField', 1, 'title', 'GMT+01:00', 'script'),
(NULL, 244, 'pjField', 1, 'title', 'GMT+10:00', 'script'),
(NULL, 245, 'pjField', 1, 'title', 'GMT+11:00', 'script'),
(NULL, 246, 'pjField', 1, 'title', 'GMT+12:00', 'script'),
(NULL, 247, 'pjField', 1, 'title', 'GMT+13:00', 'script'),
(NULL, 248, 'pjField', 1, 'title', 'GMT+02:00', 'script'),
(NULL, 249, 'pjField', 1, 'title', 'Inactive', 'script'),
(NULL, 250, 'pjField', 1, 'title', 'Active', 'script'),
(NULL, 251, 'pjField', 1, 'title', 'No', 'script'),
(NULL, 252, 'pjField', 1, 'title', 'Yes', 'script'),
(NULL, 278, 'pjField', 1, 'title', 'Forms', 'script'),
(NULL, 279, 'pjField', 1, 'title', 'Create form', 'script'),
(NULL, 280, 'pjField', 1, 'title', 'Form name', 'script'),
(NULL, 281, 'pjField', 1, 'title', 'All', 'script'),
(NULL, 282, 'pjField', 1, 'title', 'Active', 'script'),
(NULL, 283, 'pjField', 1, 'title', 'Inactive', 'script'),
(NULL, 284, 'pjField', 1, 'title', 'Delete selected', 'script'),
(NULL, 285, 'pjField', 1, 'title', 'Are you sure that you want to delete selected record(s)?', 'script'),
(NULL, 286, 'pjField', 1, 'title', 'Form details', 'script'),
(NULL, 287, 'pjField', 1, 'title', 'Form fields', 'script'),
(NULL, 288, 'pjField', 1, 'title', 'Install', 'script'),
(NULL, 289, 'pjField', 1, 'title', 'Form updated', 'script'),
(NULL, 290, 'pjField', 1, 'title', 'Form created', 'script'),
(NULL, 291, 'pjField', 1, 'title', 'Form failed to create', 'script'),
(NULL, 292, 'pjField', 1, 'title', 'Form not found', 'script'),
(NULL, 293, 'pjField', 1, 'title', 'All changes made to the form have been saved.', 'script'),
(NULL, 294, 'pjField', 1, 'title', 'A new form has been created successfully.', 'script'),
(NULL, 295, 'pjField', 1, 'title', 'We are sorry that the form could not be created properly.', 'script'),
(NULL, 296, 'pjField', 1, 'title', 'We are sorry the form you are looking for is missing.', 'script'),
(NULL, 297, 'pjField', 1, 'title', 'Form width', 'script'),
(NULL, 298, 'pjField', 1, 'title', 'pixels', 'script'),
(NULL, 299, 'pjField', 1, 'title', 'Label width', 'script'),
(NULL, 300, 'pjField', 1, 'title', 'Label position', 'script'),
(NULL, 301, 'pjField', 1, 'title', 'Right aligned labels', 'script'),
(NULL, 302, 'pjField', 1, 'title', 'Left aligned labels', 'script'),
(NULL, 303, 'pjField', 1, 'title', 'Top aligned labels', 'script'),
(NULL, 304, 'pjField', 1, 'title', 'Submit button title', 'script'),
(NULL, 305, 'pjField', 1, 'title', 'Date format', 'script'),
(NULL, 306, 'pjField', 1, 'title', 'Captcha enable', 'script'),
(NULL, 332, 'pjField', 1, 'title', 'Email format', 'script'),
(NULL, 333, 'pjField', 1, 'title', 'Plain text', 'script'),
(NULL, 334, 'pjField', 1, 'title', 'HTML', 'script'),
(NULL, 335, 'pjField', 1, 'title', 'Mailer type', 'script'),
(NULL, 336, 'pjField', 1, 'title', 'PHP mail()', 'script'),
(NULL, 337, 'pjField', 1, 'title', 'SMTP', 'script'),
(NULL, 338, 'pjField', 1, 'title', 'Confirmation options', 'script'),
(NULL, 339, 'pjField', 1, 'title', 'Confirmation message', 'script'),
(NULL, 340, 'pjField', 1, 'title', 'Redirect URL', 'script'),
(NULL, 341, 'pjField', 1, 'title', 'Confirmation message', 'script'),
(NULL, 342, 'pjField', 1, 'title', 'Redirect URL', 'script'),
(NULL, 343, 'pjField', 1, 'title', 'Send to', 'script'),
(NULL, 344, 'pjField', 1, 'title', 'Email subject', 'script'),
(NULL, 345, 'pjField', 1, 'title', 'Form styles', 'script'),
(NULL, 346, 'pjField', 1, 'title', 'Auto responder', 'script'),
(NULL, 347, 'pjField', 1, 'title', 'submit button title for your contact form', 'script'),
(NULL, 348, 'pjField', 1, 'title', 'Choose date and time format for all form date picker fields', 'script'),
(NULL, 349, 'pjField', 1, 'title', 'select ''Yes'' if you want to have captcha verification in the form.', 'script'),
(NULL, 350, 'pjField', 1, 'title', 'Select all users who will receive an email confirmation when the form is submitted.', 'script'),
(NULL, 351, 'pjField', 1, 'title', 'Enter email message subject for the confirmation message being sent', 'script'),
(NULL, 352, 'pjField', 1, 'title', 'you can either use PHP mail() function or SMTP method to send emails', 'script'),
(NULL, 353, 'pjField', 1, 'title', 'Set the format (plain text or HTML) for the confirmation email that will be sent', 'script'),
(NULL, 354, 'pjField', 1, 'title', 'When form is submitted you can either show a thank you message or redirect them to external web page.', 'script'),
(NULL, 355, 'pjField', 1, 'title', 'Auto responder settings', 'script'),
(NULL, 356, 'pjField', 1, 'title', 'If you have at least one email field on your form with "Send confirmation" checkbox selected and you enter subject and message for auto responder message here, then when the form is submitted, the message below will be sent to the user''s email address.', 'script'),
(NULL, 357, 'pjField', 1, 'title', 'Subject', 'script'),
(NULL, 358, 'pjField', 1, 'title', 'Message', 'script'),
(NULL, 359, 'pjField', 1, 'title', 'Font family', 'script'),
(NULL, 360, 'pjField', 1, 'title', 'Font size', 'script'),
(NULL, 361, 'pjField', 1, 'title', 'Font color', 'script'),
(NULL, 362, 'pjField', 1, 'title', 'Background color', 'script'),
(NULL, 363, 'pjField', 1, 'title', 'Add new field', 'script'),
(NULL, 364, 'pjField', 1, 'title', 'Edit field', 'script'),
(NULL, 365, 'pjField', 1, 'title', 'Medium heading text', 'script'),
(NULL, 366, 'pjField', 1, 'title', 'Large heading text', 'script'),
(NULL, 367, 'pjField', 1, 'title', 'Small heading text', 'script'),
(NULL, 393, 'pjField', 1, 'title', 'Field label', 'script'),
(NULL, 394, 'pjField', 1, 'title', 'Heading size', 'script'),
(NULL, 395, 'pjField', 1, 'title', 'Small', 'script'),
(NULL, 396, 'pjField', 1, 'title', 'Medium', 'script'),
(NULL, 397, 'pjField', 1, 'title', 'Large', 'script'),
(NULL, 398, 'pjField', 1, 'title', 'Heading text', 'script'),
(NULL, 399, 'pjField', 1, 'title', 'Label', 'script'),
(NULL, 400, 'pjField', 1, 'title', 'Required', 'script'),
(NULL, 401, 'pjField', 1, 'title', 'Default value', 'script'),
(NULL, 402, 'pjField', 1, 'title', 'Hint text', 'script'),
(NULL, 403, 'pjField', 1, 'title', 'Size', 'script'),
(NULL, 404, 'pjField', 1, 'title', 'Max length', 'script'),
(NULL, 405, 'pjField', 1, 'title', 'Validation', 'script'),
(NULL, 406, 'pjField', 1, 'title', 'None', 'script'),
(NULL, 408, 'pjField', 1, 'title', 'URL', 'script'),
(NULL, 409, 'pjField', 1, 'title', 'Numeric', 'script'),
(NULL, 410, 'pjField', 1, 'title', 'Alphabetic', 'script'),
(NULL, 411, 'pjField', 1, 'title', 'Alpha & numeric', 'script'),
(NULL, 412, 'pjField', 1, 'title', 'Columns', 'script'),
(NULL, 413, 'pjField', 1, 'title', 'Rows', 'script'),
(NULL, 414, 'pjField', 1, 'title', 'Option data', 'script'),
(NULL, 415, 'pjField', 1, 'title', 'Option 1', 'script'),
(NULL, 416, 'pjField', 1, 'title', 'Option 2', 'script'),
(NULL, 417, 'pjField', 1, 'title', 'Option 3', 'script'),
(NULL, 418, 'pjField', 1, 'title', 'Max file size(MB)', 'script'),
(NULL, 419, 'pjField', 1, 'title', 'Extensions', 'script'),
(NULL, 420, 'pjField', 1, 'title', 'Allow multiple', 'script'),
(NULL, 421, 'pjField', 1, 'title', 'pdf|doc|docx|xls|xlsx|csv|txt|rtf|html|zip|mp3|wma|mpg|flv|avi|jpg|jpeg|png|gif', 'script'),
(NULL, 422, 'pjField', 1, 'title', 'Submit', 'script'),
(NULL, 423, 'pjField', 1, 'title', 'Delete field', 'script'),
(NULL, 424, 'pjField', 1, 'title', 'Are you sure that you want to delete this field?', 'script'),
(NULL, 450, 'pjField', 1, 'title', 'Javascript installation code', 'script'),
(NULL, 451, 'pjField', 1, 'title', 'With JavaScript integration method you can copy the code on your web page and form will appear there. If you decide to make changes to your form there is no need to update your web page as the JS code will load the new changes you made to your form.', 'script'),
(NULL, 452, 'pjField', 1, 'title', 'Click on a form element below to add it to your form.', 'script'),
(NULL, 453, 'pjField', 1, 'title', 'Form options', 'script'),
(NULL, 454, 'pjField', 1, 'title', 'Set different configuration options for your form. There is an info icon next to each option with more details about it.', 'script'),
(NULL, 455, 'pjField', 1, 'title', 'Form styles', 'script'),
(NULL, 456, 'pjField', 1, 'title', 'Set different style options for your form. If you want to further customize your form you can use the "HTML installation code" under the Install tab.', 'script'),
(NULL, 457, 'pjField', 1, 'title', 'Preview form', 'script'),
(NULL, 458, 'pjField', 1, 'title', 'Required error message', 'script'),
(NULL, 459, 'pjField', 1, 'title', 'Validation error message', 'script'),
(NULL, 460, 'pjField', 1, 'title', 'Max file size error message', 'script'),
(NULL, 461, 'pjField', 1, 'title', 'Extension error message', 'script'),
(NULL, 462, 'pjField', 1, 'title', 'Email error message', 'script'),
(NULL, 463, 'pjField', 1, 'title', 'Captcha required message', 'script'),
(NULL, 464, 'pjField', 1, 'title', 'This is the error message shown if user submit the form without entering value for Captcha field.', 'script'),
(NULL, 465, 'pjField', 1, 'title', 'Incorrect captcha message', 'script'),
(NULL, 466, 'pjField', 1, 'title', 'This is the error message shown if user enter wrong Captcha value.', 'script'),
(NULL, 467, 'pjField', 1, 'title', 'Time format', 'script'),
(NULL, 468, 'pjField', 1, 'title', 'Submissions', 'script'),
(NULL, 469, 'pjField', 1, 'title', 'This field is required.', 'script'),
(NULL, 470, 'pjField', 1, 'title', 'Create your form by adding a new field.', 'script'),
(NULL, 496, 'pjField', 1, 'title', 'HTML installation code', 'script'),
(NULL, 497, 'pjField', 1, 'title', 'If you are experienced with HTML and want to customize your form, you can use this integration method. Just copy the code and paste it on your web page. You can change the layout, colors, fonts, borders, etc. Do not change the form fields - "Count" and "Names". Please, bear in mind that, if you decide to edit your form using the "Form fields" tab, you will need to copy the new generated HTML installation code and paste it on your web page again.', 'script'),
(NULL, 499, 'pjField', 1, 'title', 'Submission', 'script'),
(NULL, 500, 'pjField', 1, 'title', 'Forms', 'script'),
(NULL, 501, 'pjField', 1, 'title', 'Form', 'script'),
(NULL, 502, 'pjField', 1, 'title', 'Users', 'script'),
(NULL, 503, 'pjField', 1, 'title', 'User', 'script'),
(NULL, 504, 'pjField', 1, 'title', 'Last Submissions', 'script'),
(NULL, 505, 'pjField', 1, 'title', 'Most Popular Forms', 'script'),
(NULL, 506, 'pjField', 1, 'title', 'Last Logged in Users', 'script'),
(NULL, 507, 'pjField', 1, 'title', 'There is no submission found.', 'script'),
(NULL, 508, 'pjField', 1, 'title', 'There is no form found.', 'script'),
(NULL, 509, 'pjField', 1, 'title', 'There is no user found.', 'script'),
(NULL, 510, 'pjField', 1, 'title', 'Last login', 'script'),
(NULL, 511, 'pjField', 1, 'title', 'Form fields', 'script'),
(NULL, 512, 'pjField', 1, 'title', 'Click on field type in the box on the right and it will be added to your form. You can mouse over each of the fields and edit, move or delete selected field.', 'script'),
(NULL, 538, 'pjField', 1, 'title', 'Form list', 'script'),
(NULL, 539, 'pjField', 1, 'title', 'Below is the list of contact forms and number of submissions of each form. You can also click on the ''View'' icon to preview the contact form', 'script'),
(NULL, 540, 'pjField', 1, 'title', 'Add new form', 'script'),
(NULL, 541, 'pjField', 1, 'title', 'Please enter the form title and click ''Save'' button. Then, you can define necessary fields for the form and properties of fields as well.', 'script'),
(NULL, 542, 'pjField', 1, 'title', 'Submissions', 'script'),
(NULL, 543, 'pjField', 1, 'title', 'Below is the list of submissions made for this form. You can click on the ''View'' icon or ''Print'' icon to preview submission details.', 'script'),
(NULL, 569, 'pjField', 1, 'title', 'Captcha type', 'script'),
(NULL, 570, 'pjField', 1, 'title', 'Random string', 'script'),
(NULL, 571, 'pjField', 1, 'title', 'Math', 'script'),
(NULL, 572, 'pjField', 1, 'title', 'Reject links', 'script'),
(NULL, 573, 'pjField', 1, 'title', 'For better security and spam protection you can reject form submissions if there are link(s) in any of the text boxes and text areas on your form.', 'script'),
(NULL, 574, 'pjField', 1, 'title', 'Block words', 'script'),
(NULL, 575, 'pjField', 1, 'title', 'For better security and spam protection you can reject form submissions if there are certain words in any of the text boxes and text areas on your form. Just list each word you want to block on a new line.', 'script'),
(NULL, 576, 'pjField', 1, 'title', 'Message blocked due to banned words used.', 'script'),
(NULL, 577, 'pjField', 1, 'title', 'Invalid url', 'script'),
(NULL, 578, 'pjField', 1, 'title', 'Send confirmation', 'script'),
(NULL, 579, 'pjField', 1, 'title', 'Field background color', 'script');



INSERT INTO `contactform_fields` VALUES (NULL, 'front_file_not_found', 'frontend', 'Label / File not found', 'script', '2015-01-28 15:08:12');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::',  'title', 'File not found', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'front_err_ARRAY_url', 'arrays', 'front_err_ARRAY_url', 'script', '2015-01-29 15:52:08');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::',  'title', 'Link or url is not allowed in form fields.', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'front_err_ARRAY_word', 'arrays', 'front_err_ARRAY_word', 'script', '2015-01-29 15:52:42');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::',  'title', 'Message blocked due to banned words used.', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'front_err_ARRAY_redirect', 'arrays', 'front_err_ARRAY_redirect', 'script', '2015-03-20 16:07:38');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::',  'title', 'You will be redirected in few seconds...', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'lblLastSubmission', 'backend', 'Label / Last submission', 'script', '2015-05-12 15:58:20');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::',  'title', 'Last submission', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'lblJavascript', 'backend', 'Label / Javascript', 'script', '2015-05-12 16:18:26');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::',  'title', 'Javascript', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'lblFormSourceCode', 'backend', 'Label / Form source code', 'script', '2015-05-12 16:18:55');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::',  'title', 'Form source code', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'lblPreview', 'backend', 'Label / Preview', 'script', '2015-05-14 10:59:29');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::',  'title', 'Preview', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'lblDateTime', 'backend', 'Label / Date time', 'script', '2015-05-14 12:57:47');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::',  'title', 'Date time', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'lblFilterByForm', 'backend', 'Label / Filter by form', 'script', '2015-05-18 09:57:19');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::',  'title', 'Filter by form', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'infoUsersTitle', 'backend', 'Infobox / Users', 'script', '2015-05-18 10:09:26');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::',  'title', 'Users', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'infoUsersDesc', 'backend', 'Infobox / Users', 'script', '2015-05-18 10:09:56');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::',  'title', 'Below you can see users who have access to the Contact Form Generator administration pages. There are two types of users Administrators and Editors only. Click on "+ Add user" button to add a new user.', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'btnAddUser', 'backend', 'Button / + Add user', 'script', '2015-05-18 10:11:03');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::',  'title', '+ Add user', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'infoAddUserTitle', 'backend', 'Infobox / Add user', 'script', '2015-05-18 10:21:12');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::',  'title', 'Add user', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'infoAddUserDesc', 'backend', 'Infobox / Add user', 'script', '2015-05-18 10:21:30');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::',  'title', 'You can add administrator user who has full access to administration page or add an editor user who will only be able to view form submissions and will not be able to modify options, forms, other users.', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'infoUpdateUserTitle', 'backend', 'Infobox / Update user', 'script', '2015-05-18 10:23:57');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::',  'title', 'Update user', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'infoUpdateUserDesc', 'backend', 'Infobox / Update user', 'script', '2015-05-18 10:24:56');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::',  'title', 'You can make any change on the form below and click "Save" button to update user information.', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'front_form_not_found', 'frontend', 'Label / Form not found', 'script', '2015-05-19 11:20:25');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::',  'title', 'Form not found', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'gridEmptyTitle', 'backend', 'Grid / No records selected', 'script', '2015-05-19 11:54:21');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::',  'title', 'No records selected', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'gridEmptyBody', 'backend', 'Grid / No records selected', 'script', '2015-05-19 11:55:06');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::',  'title', 'You need to select at least a single record.', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'lblDateSplashTime', 'backend', 'Label / Date / Time', 'script', '2015-05-21 13:57:39');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::',  'title', 'Date / Time', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'lblButtonBackgroundColor', 'backend', 'Label / Button background color', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::',  'title', 'Button background color', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'lblButtonBorderColor', 'backend', 'Label / Button border color', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::',  'title', 'Button border color', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'lblButtonHoverBackgroundColor', 'backend', 'Label / Button hover background color', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::',  'title', 'Button hover background color', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'lblButtonHoverBorderColor', 'backend', 'Label / Button hover border color', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::',  'title', 'Button hover border color', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'field_titles_ARRAY_heading', 'arrays', 'field_titles_ARRAY_heading', 'script', '2015-06-26 10:23:46');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '1', 'title', 'Heading', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'field_titles_ARRAY_textbox', 'arrays', 'field_titles_ARRAY_textbox', 'script', '2015-06-26 10:24:17');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '1', 'title', 'Text Box', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'field_titles_ARRAY_email', 'arrays', 'field_titles_ARRAY_email', 'script', '2015-06-26 10:24:40');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '1', 'title', 'Email', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'field_titles_ARRAY_textarea', 'arrays', 'field_titles_ARRAY_textarea', 'script', '2015-06-26 10:25:02');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '1', 'title', 'Text Area', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'field_titles_ARRAY_dropdown', 'arrays', 'field_titles_ARRAY_dropdown', 'script', '2015-06-26 10:25:25');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '1', 'title', 'Drop Down', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'field_titles_ARRAY_radio', 'arrays', 'field_titles_ARRAY_radio', 'script', '2015-06-26 10:25:48');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '1', 'title', 'Radio Button', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'field_titles_ARRAY_checkbox', 'arrays', 'field_titles_ARRAY_checkbox', 'script', '2015-06-26 10:26:13');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '1', 'title', 'Check Box', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'field_titles_ARRAY_fileupload', 'arrays', 'field_titles_ARRAY_fileupload', 'script', '2015-06-26 10:26:40');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '1', 'title', 'File Upload', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'field_titles_ARRAY_datepicker', 'arrays', 'field_titles_ARRAY_datepicker', 'script', '2015-06-26 10:27:04');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '1', 'title', 'Date Picker', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'field_titles_ARRAY_captcha', 'arrays', 'field_titles_ARRAY_captcha', 'script', '2015-06-26 10:27:28');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '1', 'title', 'Captcha', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'field_titles_ARRAY_button', 'arrays', 'field_titles_ARRAY_button', 'script', '2015-06-26 10:27:52');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '1', 'title', 'Submit Button', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'lblWidthPercentage', 'backend', 'Label / Width (%)', 'script', '2015-07-20 16:05:25');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '1', 'title', 'Width (%)', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'lblHeightPixel', 'backend', 'Label / Height (px)', 'script', '2015-07-20 16:06:02');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '1', 'title', 'Height (px)', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'front_post_content_size', 'frontend', 'Label / Post content over size', 'script', '2017-03-21 03:23:28');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'The form could not be uploaded because file size is too large and your server cannot upload it. Maximum allowed size is {SIZE}. Please, upload smaller file.', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'front_upload_max_size', 'frontend', 'Label / Upload max filesize error', 'script', '2017-03-21 03:59:46');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'The file size is too large and your server cannot upload it. Upload max file size is {SIZE}. Please, upload smaller file.', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'short_days_ARRAY_0', 'arrays', 'short_days_ARRAY_0', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Su', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'short_days_ARRAY_1', 'arrays', 'short_days_ARRAY_1', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Mo', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'short_days_ARRAY_2', 'arrays', 'short_days_ARRAY_2', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Tu', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'short_days_ARRAY_3', 'arrays', 'short_days_ARRAY_3', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'We', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'short_days_ARRAY_4', 'arrays', 'short_days_ARRAY_4', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Th', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'short_days_ARRAY_5', 'arrays', 'short_days_ARRAY_5', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Fr', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'short_days_ARRAY_6', 'arrays', 'short_days_ARRAY_6', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Sa', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'opt_o_from_email', 'backend', 'Options / Email account for email notifications', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Email account for email notifications', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'lblOptionEmailTip', 'backend', 'Label / Email tooltip', 'script', NULL);
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Set the email which users will see when they receive emails from the system.', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'infoConfirmationEmailTitle', 'backend', 'Label / Confirmation Email', 'script', '2018-04-09 02:21:15');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Confirmation Email', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'infoConfirmationEmailDesc', 'backend', 'Label / Confirmation Email', 'script', '2018-04-09 02:31:07');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'This email will be sent to who are assigned in the field "Send to" at the "Form Details" tab. Please use the token {Fields} to customize the email message. This token will hold all the form fields in the contact form.', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'lblConfirmationEmail', 'backend', 'Label / Confirmation Email', 'script', '2018-04-09 02:25:49');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Confirmation Email', 'script');

INSERT INTO `contactform_fields` VALUES (NULL, 'front_err_ARRAY_form_inactive', 'backend', 'Label / Form is inactive', 'script', '2018-04-09 02:25:49');
SET @id := (SELECT LAST_INSERT_ID());
INSERT INTO `contactform_multi_lang` VALUES (NULL, @id, 'pjField', '::LOCALE::', 'title', 'Form is inactive', 'script');

