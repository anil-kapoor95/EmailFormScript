<?php
if (!defined("ROOT_PATH"))
{
	header("HTTP/1.1 403 Forbidden");
	exit;
}
class pjSubmissionModel extends pjAppModel
{
	protected $primaryKey = 'id';
	
	protected $table = 'submissions';
	
	protected $schema = array(
		array('name' => 'id', 'type' => 'int', 'default' => ':NULL'),
		array('name' => 'form_id', 'type' => 'int', 'default' => ':NULL'),
		array('name' => 'ip', 'type' => 'varchar', 'default' => ':NULL'),
		array('name' => 'submitted_date', 'type' => 'datetime', 'default' => ':NOW()')
	);
	
	public static function factory($attr=array())
	{
		return new pjSubmissionModel($attr);
	}
}
?>