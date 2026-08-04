<?php
if (!defined("ROOT_PATH"))
{
	header("HTTP/1.1 403 Forbidden");
	exit;
}
class pjUserFormModel extends pjAppModel
{
	protected $table = 'users_forms';
	
	protected $schema = array(
		array('name' => 'user_id', 'type' => 'int', 'default' => ':NULL'),
		array('name' => 'form_id', 'type' => 'int', 'default' => ':NULL')
	);
	
	public static function factory($attr=array())
	{
		return new pjUserFormModel($attr);
	}
}
?>