<?php
if (!defined("ROOT_PATH"))
{
	header("HTTP/1.1 403 Forbidden");
	exit;
}
class pjAdminSubmissions extends pjAdmin
{
	public function pjActionIndex()
	{
		$this->checkLogin();
		
		if ($this->isAdmin() || $this->isEditor())
		{
			$form_arr = pjFormModel::factory()
				->where('t1.status', 'T')
				->orderBy("form_title ASC")
				->findAll()
				->getData();
			
			$this->set('form_arr', $form_arr);
			
			$this->appendJs('jquery.datagrid.js', PJ_FRAMEWORK_LIBS_PATH . 'pj/js/');
			$this->appendJs('pjAdminSubmissions.js');
			$this->appendJs('index.php?controller=pjAdmin&action=pjActionMessages', PJ_INSTALL_URL, true);
		} else {
			$this->set('status', 2);
		}
	}
	
	public function pjActionDeleteSubmission()
	{
		$this->setAjax(true);
	
		if ($this->isXHR())
		{
			$response = array();
			
			if (pjSubmissionModel::factory()->setAttributes(array('id' => $_GET['id']))->erase()->getAffectedRows() == 1)
			{
				$pjFileModel = pjFileModel::factory();
				$file_arr = $pjFileModel->reset()->where('submission_id', $_GET['id'])->findAll()->getData();
				foreach($file_arr as $file)
				{
					$file_path = $file['file_path'];
					if (file_exists(PJ_INSTALL_PATH . $file_path)) {
						if(unlink(PJ_INSTALL_PATH . $file_path)){
						}
					}
				}
				pjSubmissionDetailModel::factory()->where('submission_id', $_GET['id'])->eraseAll();
				$pjFileModel->reset()->where('submission_id', $_GET['id'])->eraseAll();
				$response['code'] = 200;
			} else {
				$response['code'] = 100;
			}
			
			pjAppController::jsonResponse($response);
		}
		exit;
	}
	
	public function pjActionDeleteSubmissionBulk()
	{
		$this->setAjax(true);
	
		if ($this->isXHR())
		{
			if (isset($_POST['record']) && count($_POST['record']) > 0)
			{
				$pjFileModel = pjFileModel::factory();
				$file_arr = $pjFileModel->reset()->whereIn('submission_id', $_POST['record'])->findAll()->getData();
				foreach($file_arr as $file)
				{
					$file_path = $file['file_path'];
					if (file_exists(PJ_INSTALL_PATH . $file_path)) {
						if(unlink(PJ_INSTALL_PATH . $file_path)){
						}
					}
				}
				pjSubmissionModel::factory()->whereIn('id', $_POST['record'])->eraseAll();
				pjSubmissionDetailModel::factory()->whereIn('submission_id', $_POST['record'])->eraseAll();
				$pjFileModel->reset()->whereIn('submission_id', $_POST['record'])->eraseAll();
			}
		}
		exit;
	}
	
	public function pjActionGetSubmissions()
	{
		$this->setAjax(true);
		if ($this->isXHR())
		{
			$pjSubmissionModel = pjSubmissionModel::factory()
				->join("pjForm", "t1.form_id=t2.id", "left");
			
			if (isset($_GET['form_id']) && (int) $_GET['form_id'] > 0)
			{
				$pjSubmissionModel->where('t1.form_id', $_GET['form_id']);
			}
			if (isset($_GET['q']) && !empty($_GET['q']))
			{
				$q = pjObject::escapeString($_GET['q']);
				$pjSubmissionModel->where("t1.id IN (SELECT t3.submission_id FROM `".pjSubmissionDetailModel::factory()->getTable()."` AS t3 WHERE t3.value LIKE '%".$q."%')");
			}
			
			$column = 'submitted_date';
			$direction = 'DESC';
			if (isset($_GET['direction']) && isset($_GET['column']) && in_array(strtoupper($_GET['direction']), array('ASC', 'DESC')))
			{
				$column = $_GET['column'];
				$direction = strtoupper($_GET['direction']);
			}
			
			$total = $pjSubmissionModel->findCount()->getData();
			$rowCount = isset($_GET['rowCount']) && (int) $_GET['rowCount'] > 0 ? (int) $_GET['rowCount'] : 10;
			$pages = ceil($total / $rowCount);
			$page = isset($_GET['page']) && (int) $_GET['page'] > 0 ? intval($_GET['page']) : 1;
			$offset = ((int) $page - 1) * $rowCount;
			if ($page > $pages)
			{
				$page = $pages;
			}

			$data = array();
			
			$data = $pjSubmissionModel
				->select("t1.*, t2.form_title")
				->orderBy("$column $direction")
				->limit($rowCount, $offset)
				->findAll()
				->getData();
			foreach($data as $k => $v)
			{
				$v['submitted_date'] = date($this->option_arr['o_date_format'], strtotime($v['submitted_date'])) . ', ' . date($this->option_arr['o_time_format'], strtotime($v['submitted_date']));
				$data[$k] = $v;
			}
				
			pjAppController::jsonResponse(compact('data', 'total', 'pages', 'page', 'rowCount', 'column', 'direction'));
		}
		exit;
	}
	
	public function pjActionView()
	{
		$this->setAjax(true);
	
		if ($this->isXHR())
		{
			$submission_arr = pjSubmissionModel::factory()
				->find($_GET['submission_id'])
				->getData();
			$arr = pjFormModel::factory()
				->find($submission_arr['form_id'])
				->getData();
			$field_arr = pjSubmissionDetailModel::factory()
						->select("t1.*, t2.label, t2.heading_size")
						->join('pjFormField', "t1.field_id = t2.id", 'left')
						->where('submission_id', $_GET['submission_id'])
						->orderBy("t2.order_id ASC")->findAll()->getData();
						
			$file_arr = array();			
			$files = pjFileModel::factory()
				->where('form_id', $submission_arr['form_id'])
				->where('submission_id', $_GET['submission_id'])
				->findAll()
				->getData();
			foreach($files as $k => $v){
				$file_arr[$v['field_id']][] = $v;
			}
			
			$this->set('arr', $arr);
			$this->set('submission_arr', $submission_arr);
			$this->set('field_arr', $field_arr);
			$this->set('file_arr', $file_arr);
		}
	}
	
	public function pjActionPrint()
	{
		$this->setLayout('pjActionPrint');
		
		$submission_arr = pjSubmissionModel::factory()
			->find($_GET['submission_id'])
			->getData();
		$arr = pjFormModel::factory()
			->find($submission_arr['form_id'])
			->getData();
		$field_arr = pjSubmissionDetailModel::factory()
			->select("t1.*, t2.label, t2.heading_size")
			->join('pjFormField', "t1.field_id = t2.id", 'left')
			->where('submission_id', $_GET['submission_id'])
			->orderBy("t2.order_id ASC")
			->findAll()
			->getData();
		
		$file_arr = array();			
		$files = pjFileModel::factory()
			->where('form_id', $submission_arr['form_id'])
			->where('submission_id', $_GET['submission_id'])
			->findAll()
			->getData();
		foreach($files as $k => $v){
			$file_arr[$v['field_id']][] = $v;
		}
		
		$this->set('arr', $arr);
		$this->set('field_arr', $field_arr);
		$this->set('file_arr', $file_arr);
	}
}
?>