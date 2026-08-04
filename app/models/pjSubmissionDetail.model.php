<?php
if (!defined("ROOT_PATH"))
{
	header("HTTP/1.1 403 Forbidden");
	exit;
}
class pjSubmissionDetailModel extends pjAppModel
{
	protected $table = 'submission_details';
	
	protected $schema = array(
		array('name' => 'form_id', 'type' => 'int', 'default' => ':NULL'),
		array('name' => 'submission_id', 'type' => 'int', 'default' => ':NULL'),
		array('name' => 'field_id', 'type' => 'int', 'default' => ':NULL'),
		array('name' => 'type', 'type' => 'varchar', 'default' => ':NULL'),
		array('name' => 'value', 'type' => 'text', 'default' => ':NULL')
	);
	
	public static function factory($attr=array())
	{
		return new pjSubmissionDetailModel($attr);
	}
}
?>