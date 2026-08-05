START TRANSACTION;

INSERT IGNORE INTO `fields` (`key`,`type`,`label`,`source`) VALUES ('error_titles_ARRAY_AG01','arrays','error_titles_ARRAY_AG01','script');
SET @id := (SELECT `id` FROM `fields` WHERE `key`='error_titles_ARRAY_AG01' LIMIT 1);
INSERT IGNORE INTO `multi_lang` (`foreign_id`,`model`,`locale`,`field`,`content`,`source`) VALUES (@id,'pjField','::LOCALE::','title','Security check failed','script');

INSERT IGNORE INTO `fields` (`key`,`type`,`label`,`source`) VALUES ('error_bodies_ARRAY_AG01','arrays','error_bodies_ARRAY_AG01','script');
SET @id := (SELECT `id` FROM `fields` WHERE `key`='error_bodies_ARRAY_AG01' LIMIT 1);
INSERT IGNORE INTO `multi_lang` (`foreign_id`,`model`,`locale`,`field`,`content`,`source`) VALUES (@id,'pjField','::LOCALE::','title','Your security token was missing or invalid. Please try again.','script');

COMMIT;