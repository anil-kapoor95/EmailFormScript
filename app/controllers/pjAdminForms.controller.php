<?php
if (!defined("ROOT_PATH"))
{
	header("HTTP/1.1 403 Forbidden");
	exit;
}
class pjAdminForms extends pjAdmin
{
	public function pjActionIndex()
	{
		$this->checkLogin();
		
		if ($this->isAdmin() || $this->isEditor())
		{
			$this->appendJs('jquery.datagrid.js', PJ_FRAMEWORK_LIBS_PATH . 'pj/js/');
			$this->appendJs('pjAdminForms.js');
			$this->appendJs('index.php?controller=pjAdmin&action=pjActionMessages', PJ_INSTALL_URL, true);
		} else {
			$this->set('status', 2);
		}
	}
	
	public function pjActionGetForm()
	{
		$this->setAjax(true);
	
		if ($this->isXHR())
		{
			$pjFormModel = pjFormModel::factory();
			
			if (isset($_GET['q']) && !empty($_GET['q']))
			{
				$q = pjObject::escapeString($_GET['q']);
				$pjFormModel->where('t1.form_title LIKE', "%$q%");
			}

			if (isset($_GET['status']) && !empty($_GET['status']) && in_array($_GET['status'], array('T', 'F')))
			{
				$pjFormModel->where('t1.status', $_GET['status']);
			}
				
			$column = 'created';
			$direction = 'DESC';
			if (isset($_GET['direction']) && isset($_GET['column']) && in_array(strtoupper($_GET['direction']), array('ASC', 'DESC')))
			{
				$column = $_GET['column'];
				$direction = strtoupper($_GET['direction']);
			}

			$total = $pjFormModel->findCount()->getData();
			$rowCount = isset($_GET['rowCount']) && (int) $_GET['rowCount'] > 0 ? (int) $_GET['rowCount'] : 10;
			$pages = ceil($total / $rowCount);
			$page = isset($_GET['page']) && (int) $_GET['page'] > 0 ? intval($_GET['page']) : 1;
			$offset = ((int) $page - 1) * $rowCount;
			if ($page > $pages)
			{
				$page = $pages;
			}

			$data = $pjFormModel
				->select("t1.*, 
						  (SELECT COUNT(*) FROM `".pjSubmissionModel::factory()->getTable()."` AS t2 WHERE t2.form_id = t1.id) as cnt_submissions,
						  (SELECT CONCAT(submitted_date, '~:~', t3.id) FROM `".pjSubmissionModel::factory()->getTable()."` AS t3 WHERE t3.form_id=t1.id ORDER BY submitted_date DESC LIMIT 1) AS date_time")
				->orderBy("$column $direction")
				->limit($rowCount, $offset)
				->findAll()
				->getData();
			foreach($data as $k => $v)
			{
				if(!empty($v['date_time'] ))
				{
					list($date_time, $submission_id) = explode("~:~", $v['date_time']);
					$v['date_time'] = date($this->option_arr['o_date_format'], strtotime($date_time)) . ', ' . date($this->option_arr['o_time_format'], strtotime($date_time));
					$v['submission_id'] = $submission_id;
					
				}
				$data[$k] = $v;
			}	
			pjAppController::jsonResponse(compact('data', 'total', 'pages', 'page', 'rowCount', 'column', 'direction'));
		}
		exit;
	}
	
	public function pjActionCreate()
	{
		$this->checkLogin();
		
		if ($this->isAdmin())
		{
			if (isset($_POST['form_create']))
			{
				$data = array();
				$data['subject'] = 'Form submission';
				$data['confirm_message'] = 'Thank you!';
				$id = pjFormModel::factory(array_merge($_POST, $data))->insert()->getInsertId();
				if ($id !== false && (int) $id > 0)
				{
					pjUserFormModel::factory()->setAttributes(array('form_id' => $id, 'user_id' => '1'))->insert();
					
					$err = 'AF03';
				} else {
					$err = 'AF04';
				}
				pjUtil::redirect($_SERVER['PHP_SELF'] . "?controller=pjAdminForms&action=pjActionUpdate&id=" . $id . "&tab_id=tabs-1" . "&err=$err");
			} else {
						
				$this->appendJs('jquery.validate.min.js', PJ_THIRD_PARTY_PATH . 'validate/');
				$this->appendJs('pjAdminForms.js');
			}
		} else {
			$this->set('status', 2);
		}
	}
	
	public function pjActionDeleteForm()
	{
		$this->setAjax(true);
	
		if ($this->isXHR())
		{
			$response = array();
			
			if (pjFormModel::factory()->setAttributes(array('id' => $_GET['id']))->erase()->getAffectedRows() == 1)
			{
				$pjFileModel = pjFileModel::factory();
				$file_arr = $pjFileModel->where('form_id', $_GET['id'])->findAll()->getData();
				foreach($file_arr as $file)
				{
					$file_path = $file['file_path'];
					if (file_exists(PJ_INSTALL_PATH . $file_path)) {
						if(unlink(PJ_INSTALL_PATH . $file_path)){
						}
					}
				}
				pjFormFieldModel::factory()->where('form_id', $_GET['id'])->eraseAll();
				$pjFileModel->reset()->where('form_id', $_GET['id'])->eraseAll();
				pjSubmissionModel::factory()->where('form_id', $_GET['id'])->eraseAll();
				pjSubmissionDetailModel::factory()->where('form_id', $_GET['id'])->eraseAll();
				$response['code'] = 200;
			} else {
				$response['code'] = 100;
			}
			
			pjAppController::jsonResponse($response);
		}
		exit;
	}
	
	public function pjActionDeleteFormBulk()
	{
		$this->setAjax(true);
	
		if ($this->isXHR())
		{
			if (isset($_POST['record']) && count($_POST['record']) > 0)
			{
				$pjFileModel = pjFileModel::factory();
				$file_arr = $pjFileModel->reset()->whereIn('form_id', $_POST['record'])->findAll()->getData();
				foreach($file_arr as $file)
				{
					$file_path = $file['file_path'];
					if (file_exists(PJ_INSTALL_PATH . $file_path)) {
						if(unlink(PJ_INSTALL_PATH . $file_path)){
						}
					}
				}
				pjFormModel::factory()->whereIn('id', $_POST['record'])->eraseAll();
				pjFormFieldModel::factory()->whereIn('form_id', $_POST['record'])->eraseAll();
				$pjFileModel->reset()->whereIn('form_id', $_POST['record'])->eraseAll();
				pjSubmissionModel::factory()->where('form_id', $_GET['id'])->eraseAll();
				pjSubmissionDetailModel::factory()->where('form_id', $_GET['id'])->eraseAll();
			}
		}
		exit;
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
	
	public function pjActionExportForm()
	{
		$this->checkLogin();
		
		if (isset($_POST['record']) && is_array($_POST['record']))
		{
			$arr = pjFormModel::factory()->whereIn('id', $_POST['record'])->findAll()->getData();
			$csv = new pjCSV();
			$csv
				->setHeader(true)
				->setName("Forms-".time().".csv")
				->process($arr)
				->download();
		}
		exit;
	}
	
	public function pjActionSetActive()
	{
		$this->setAjax(true);

		if ($this->isXHR())
		{
			$pjFormModel = pjFormModel::factory();
			
			$arr = $pjFormModel->find($_POST['id'])->getData();
			
			if (count($arr) > 0)
			{
				switch ($arr['is_active'])
				{
					case 'T':
						$sql_status = 'F';
						break;
					case 'F':
						$sql_status = 'T';
						break;
					default:
						return;
				}
				$pjFormModel->reset()->setAttributes(array('id' => $_POST['id']))->modify(array('is_active' => $sql_status));
			}
		}
		exit;
	}
	
	public function pjActionSaveForm()
	{
		$this->setAjax(true);
	
		if ($this->isXHR())
		{
			pjFormModel::factory()->where('id', $_GET['id'])->limit(1)->modifyAll(array($_POST['column'] => $_POST['value']));
		}
		exit;
	}
	
	public function pjActionStatusForm()
	{
		$this->setAjax(true);
	
		if ($this->isXHR())
		{
			if (isset($_POST['record']) && count($_POST['record']) > 0)
			{
				pjFormModel::factory()->whereIn('id', $_POST['record'])->modifyAll(array(
					'status' => ":IF(`status`='F','T','F')"
				));
			}
		}
		exit;
	}
	
	public function pjActionUpdate()
	{
		$this->checkLogin();
		
		if ($this->isAdmin() || $this->isEditor())
		{
			if (isset($_POST['form_update']))
			{
				$data = array();
				
				pjFormModel::factory()->where('id', $_POST['id'])->limit(1)->modifyAll(array_merge($_POST, $data));
				
				$pjUserFormModel = pjUserFormModel::factory();
				$pjUserFormModel->where('form_id', $_POST['id'])->eraseAll();
				if(isset($_POST['user_id']))
				{
					$pjUserFormModel->reset()->begin();
					foreach ($_POST['user_id'] as $user_id){
						$data = array();
						$data['form_id'] = $_POST['id'];
						$data['user_id'] = $user_id;
						$pjUserFormModel->reset()->setAttributes($data)->insert();
					}
					$pjUserFormModel->commit();
				}
				
				pjUtil::redirect(PJ_INSTALL_URL . "index.php?controller=pjAdminForms&action=pjActionUpdate&id=" . $_POST['id'] . "&tab_id=" . $_POST['tab_id'] . "&err=AF01");
				
			} else {
				$pjFormFieldModel = pjFormFieldModel::factory();
				
				$arr = pjFormModel::factory()->find($_GET['id'])->getData();
				if (count($arr) === 0)
				{
					pjUtil::redirect(PJ_INSTALL_URL. "index.php?controller=pjAdminForms&action=pjActionIndex&err=AF08");
				}
				
				$field_arr = $pjFormFieldModel->where('form_id', $_GET['id'])->orderBy("order_id ASC")->findAll()->getData();
				$cnt_captcha = $pjFormFieldModel->reset()->where('form_id', $_GET['id'])->where('type', 'captcha')->findCount()->getData();
				
				$user_arr = pjUserModel::factory()->where('t1.status', 'T')->findAll()->getData();
				
				$user_form_arr = pjUserFormModel::factory()->where('form_id', $_GET['id'])->findAll()->getData();
				$user_id_arr = array();
				if(!empty($user_form_arr)){
					foreach($user_form_arr as $v)
					{
						$user_id_arr[] = $v['user_id'];
					}
				}
				
				$this->set('arr', $arr);
				$this->set('field_arr', $field_arr);
				$this->set('cnt_captcha', $cnt_captcha);
				$this->set('user_arr', $user_arr);
				$this->set('user_id_arr', $user_id_arr);
				
				$this->appendJs('jquery.minicolors.js', PJ_THIRD_PARTY_PATH . 'mini_colors/');
				$this->appendCss('jquery.minicolors.css', PJ_THIRD_PARTY_PATH . 'mini_colors/');
				
				$this->appendJs('jquery.tipsy.js', PJ_THIRD_PARTY_PATH . 'tipsy/');
				$this->appendCss('jquery.tipsy.css', PJ_THIRD_PARTY_PATH . 'tipsy/');
				
				$this->appendJs('chosen.jquery.min.js', PJ_THIRD_PARTY_PATH . 'chosen/');
				$this->appendCss('chosen.css', PJ_THIRD_PARTY_PATH . 'chosen/');
				$this->appendJs('tinymce.min.js', PJ_THIRD_PARTY_PATH . 'tinymce/');
				$this->appendJs('jquery.validate.min.js', PJ_THIRD_PARTY_PATH . 'validate/');
				$this->appendJs('jquery.datagrid.js', PJ_FRAMEWORK_LIBS_PATH . 'pj/js/');
				$this->appendJs('pjAdminForms.js');
				$this->appendJs('index.php?controller=pjAdmin&action=pjActionMessages', PJ_INSTALL_URL, true);
			}
		} else {
			$this->set('status', 2);
		}
	}
	
	public function pjActionLoadForm()
	{
		$this->setAjax(true);
	
		if ($this->isXHR())
		{
			$field_arr = pjFormFieldModel::factory()->where('form_id', $_GET['id'])->orderBy("order_id ASC")->findAll()->getData();
			
			$this->set('field_arr', $field_arr);
		}
	}
	
	public function pjActionSortFields()
	{
		$this->setAjax(true);
	
		if ($this->isXHR())
		{
			$response = array();
			
			$pjFormFieldModel = pjFormFieldModel::factory();
			
			foreach($_POST['field_item'] as $k => $v)
			{
				$pjFormFieldModel->reset()->set('id', $v)->modify(array('order_id' => $k+1));
			}
			
			$response['code'] = 200;
			pjAppController::jsonResponse($response);
		}
		exit;
	}
	
	public function pjActionAddField()
	{
		$this->setAjax(true);
	
		if ($this->isXHR())
		{
			$pjFormFieldModel = pjFormFieldModel::factory();
			
			$field_arr = $pjFormFieldModel->reset()->where('form_id', $_GET['id'])->limit(1)->orderBy("order_id DESC")->findAll()->getData();
			
			$order_id = 1;
			if(!empty($field_arr))
			{
				$order_id = $field_arr[0]['order_id'] + 1;
			}
			
			$data = array();
			$data['form_id'] = $_GET['id'];
			$data['type'] = $_GET['type'];
			$data['order_id'] = $order_id;
			$data['error_required'] = __('lblRequiredField', true, false);
			if($_GET['type'] == 'heading')
			{
				$data['label'] = __('lblMediumHeading', true, false);
			}else{
				$data['label'] = __('lblFieldLabel', true, false);
			}
			if($_GET['type'] == 'fileupload')
			{
				$data['extensions'] = __('lblDefaultExtensions', true, false);
			}
			$field_id = null;
			if($_GET['type'] != 'captcha'){
				$field_id = $pjFormFieldModel->reset()->setAttributes($data)->insert()->getInsertId();
			}else{
				$cnt_captcha = $pjFormFieldModel->reset()->where('form_id', $_GET['id'])->where('type', 'captcha')->findCount()->getData();
				if($cnt_captcha == 0){
					$field_id = $pjFormFieldModel->reset()->setAttributes($data)->insert()->getInsertId();
				}
			}
			
			$field_arr = $pjFormFieldModel->reset()->where('form_id', $_GET['id'])->orderBy("order_id ASC")->findAll()->getData();
			
			$arr = pjFormModel::factory()->find($_GET['id'])->getData();
			
			$this->set('field_arr', $field_arr);
			$this->set('field_id', $field_id);
			$this->set('arr', $arr);
		}
	}
	public function pjActionDeleteField()
	{
		$this->setAjax(true);
	
		if ($this->isXHR())
		{
			$pjFormFieldModel = pjFormFieldModel::factory();
			
			$_arr = $pjFormFieldModel->find($_GET['field_id'])->getData();
			
			$pjFormFieldModel->reset()->setAttributes(array('id' => $_GET['field_id']))->erase();
			
			$field_arr = $pjFormFieldModel->reset()->where('form_id', $_GET['id'])->orderBy("order_id ASC")->findAll()->getData();
			
			$arr = pjFormModel::factory()->find($_arr['form_id'])->getData();
			
			$this->set('field_arr', $field_arr);
			$this->set('arr', $arr);
		}
	}
	public function pjActionEditField()
	{
		$this->setAjax(true);
	
		if ($this->isXHR())
		{
			
			$field_arr = pjFormFieldModel::factory()->find($_GET['id'])->getData();
			$arr = pjFormModel::factory()->find($field_arr['form_id'])->getData();
			
			$this->set('field_arr', $field_arr);
			$this->set('arr', $arr);
		}
	}
	
	public function pjActionSaveField()
	{
		$this->setAjax(true);
	
		if ($this->isXHR())
		{
			$pjFormFieldModel = pjFormFieldModel::factory();
			$data = array();
			$arr = $pjFormFieldModel->find($_POST['field_id'])->getData();
			if($arr['type'] == 'radio' || $arr['type'] == 'checkbox' || $arr['type'] == 'dropdown'){
				$option = array();
				$option_arr = explode("\n", str_replace("\r", "", $_POST['option_data']));
				foreach($option_arr as $k => $v){
					$string = preg_replace('/\s+/', '', $v);
					if($string != ''){
						$option[] = $v;
					}
				}
				$_POST['option_data'] = implode("\n", $option);
			}
			$pjFormFieldModel->reset()->set('id', $_POST['field_id'])->modify($_POST);
			
			$field_arr = $pjFormFieldModel->reset()->where('form_id', $_GET['id'])->orderBy("order_id ASC")->findAll()->getData();
			
			$arr = pjFormModel::factory()->find($_GET['id'])->getData();
			
			$this->set('arr', $arr);
			$this->set('field_arr', $field_arr);
		}
	}
	
	public function pjActionPreview()
	{
		$this->setLayout('pjActionEmpty');
		
		$arr = pjFormModel::factory()->find($_GET['id'])->getData();
		$field_arr = pjFormFieldModel::factory()->where('form_id', $_GET['id'])->orderBy("order_id ASC")->findAll()->getData();
		
		$this->set('arr', $arr);
		$this->set('field_arr', $field_arr);
	}
	
	public function pjActionCode()
	{
		$this->setAjax(true);
		if ($this->isXHR())
		{
			$arr = pjFormModel::factory()->find($_GET['id'])->getData();
			$field_arr = pjFormFieldModel::factory()->where('form_id', $_GET['id'])->orderBy("order_id ASC")->findAll()->getData();
			
			$this->set('arr', $arr);
			$this->set('field_arr', $field_arr);
		}
	}
}
?>