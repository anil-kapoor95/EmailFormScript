<?php
if (!defined("ROOT_PATH"))
{
	header("HTTP/1.1 403 Forbidden");
	exit;
}
class pjFront extends pjAppController
{
	public $defaultCaptcha = 'PHPJabbersCaptcha';
	
	public $defaultLocale = 'front_locale_id';
	
	public function __construct()
	{
		$this->setLayout('pjActionFront');
		self::allowCORS();
	}

	public function isXHR()
	{
		return parent::isXHR() || isset($_SERVER['HTTP_ORIGIN']);
	}
	
	static protected function allowCORS()
	{
		$origin = isset($_SERVER['HTTP_ORIGIN']) ? $_SERVER['HTTP_ORIGIN'] : '*';
		header('P3P: CP="ALL DSP COR CUR ADM TAI OUR IND COM NAV INT"');
		header("Access-Control-Allow-Origin: $origin");
		header("Access-Control-Allow-Credentials: true");
		header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
		header("Access-Control-Allow-Headers: Origin, X-Requested-With");
	}
	
	public function afterFilter()
	{		
		
	}
	
	public function beforeFilter()
	{
		$OptionModel = pjOptionModel::factory();
		$this->option_arr = $OptionModel->getPairs($this->getForeignId());
		$this->set('option_arr', $this->option_arr);
		$this->setTime();

		if (!isset($_SESSION[$this->defaultLocale]))
		{
			pjObject::import('Model', 'pjLocale:pjLocale');
			$locale_arr = pjLocaleModel::factory()->where('is_default', 1)->limit(1)->findAll()->getData();
			if (count($locale_arr) === 1)
			{
				$this->setLocaleId($locale_arr[0]['id']);
			}
		}
		if (!in_array($_GET['action'], array('pjActionLoadCss')))
		{
			$this->loadSetFields();
		}
	}
	
	public function beforeRender()
	{
		if (isset($_GET['iframe']))
		{
			$this->setLayout('pjActionIframe');
		}
	}
	public function pjActionCaptcha()
	{
		$this->setAjax(true);
		$arr = pjFormModel::factory()->find($_GET['id'])->getData();
		if($arr['captcha_type'] == 'string'){
			$Captcha = new pjCaptcha(PJ_INSTALL_PATH.'app/web/obj/Anorexia.ttf', $this->defaultCaptcha . $_GET['id'], 6);
			$Captcha->setImage('app/web/img/button.png')->init(isset($_GET['rand']) ? $_GET['rand'] : null);
		}else{
			$Captcha = new Captcha(PJ_INSTALL_PATH.'app/web/obj/verdana.ttf', $this->defaultCaptcha . $_GET['id'], 6);
			$Captcha->setWidth(120);
			$Captcha->setImage('app/web/img/button-captcha.png');
			$Captcha->init(isset($_GET['rand']) ? $_GET['rand'] : null);
		}
	}

	public function pjActionCheckCaptcha()
	{
		$this->setAjax(true);
		if (!isset($_GET['captcha']) || empty($_GET['captcha']) || !pjCaptcha::validate($_GET['captcha'], $_SESSION[$this->defaultCaptcha . $_GET['id']])){
			echo 'false';
		}else{
			echo 'true';
		}
	}
	public function pjActionSetLocale()
	{
		$this->setLocaleId(@$_GET['locale']);
		pjUtil::redirect($_SERVER['HTTP_REFERER']);
	}
	
	public function pjActionLoadCss()
	{
		$dm = new pjDependencyManager(PJ_INSTALL_PATH, PJ_THIRD_PARTY_PATH);
		$dm->load(PJ_CONFIG_PATH . 'dependencies.php')->resolve();
		
		$theme = isset($_GET['theme']) ? $_GET['theme'] : $this->option_arr['o_theme'];
		if((int) $theme > 0)
		{
			$theme = 'theme' . $theme;
		}
		$arr = array(
			array('file' => 'front.css', 'path' => PJ_CSS_PATH),
			array('file' => 'front.txt', 'path' => PJ_CSS_PATH),
			array('file' => 'jquery-ui.custom.min.css', 'path' => $dm->getPath('pj_jquery_ui') . 'css/smoothness/'),
			array('file' => "$theme.css", 'path' => PJ_CSS_PATH)
		);
		$form = pjFormModel::factory()->find($_GET['fid'])->getData();
		header("Content-Type: text/css; charset=utf-8");
		foreach ($arr as $item)
		{
			ob_start();
			@readfile($item['path'] . $item['file']);
			$string = ob_get_contents();
			ob_end_clean();
			
			if ($string !== FALSE)
			{
				echo str_replace(
					array(
							'../img/', 
							'images/', 
							"pjWrapper",
							'[pjCF_container]',
							'[font_family]',
							'[font_size]',
							'[font_color]',
							'[background_color]',
							'[field_background_color]',
							'[button_background_color]',
							'[button_hover_background_color]',
							'[button_border_color]',
							'[button_hover_border_color]'
					),
					array(
							PJ_INSTALL_URL . PJ_IMG_PATH, 
							PJ_INSTALL_URL . $dm->getPath('pj_jquery_ui') . 'css/smoothness/images/',
							"pjWrapperContactForm_" . $_GET['fid'],
							'#pjCF_container_' . $_GET['fid'],
							$form['font_family'],
							$form['font_size'],
							strpos($form['font_color'],'#') === false ? $form['font_color'] : str_replace("#", "", $form['font_color']),
							!empty($form['background_color']) ? $form['background_color'] : 'transparent',
							!empty($form['field_background_color']) ? $form['field_background_color'] : 'transparent',
							!empty($form['button_background_color']) ? $form['button_background_color'] : 'transparent',
							!empty($form['button_hover_background_color']) ? $form['button_hover_background_color'] : 'transparent',
							strpos($form['button_border_color'],'#') === false ? $form['button_border_color'] : str_replace("#", "", $form['button_border_color']),
							strpos($form['button_hover_border_color'],'#') === false ? $form['button_hover_border_color'] : str_replace("#", "", $form['button_hover_border_color'])
					),
					$string) . "\n";
			}
		}
		
		exit;
	}
	public function pjActionLoadJs()
	{
		$this->setLayout('pjActionEmpty');
		$arr = pjFormModel::factory()->find($_GET['fid'])->getData();
		$field_arr = pjFormFieldModel::factory()->where('form_id', $_GET['fid'])->orderBy("order_id ASC")->findAll()->getData();
			
		$this->set('arr', $arr);
		$this->set('field_arr', $field_arr);
	}
	public function pjActionLoad()
	{
		ob_start();
		header("Content-Type: text/javascript; charset=utf-8");
		if(isset($_GET['fid']) && (int) $_GET['fid'] > 0)
		{
			$arr = pjFormModel::factory()->find($_GET['fid'])->getData();
			$field_arr = pjFormFieldModel::factory()->where('form_id', $_GET['fid'])->orderBy("order_id ASC")->findAll()->getData();
				
			$this->set('arr', $arr);
			$this->set('field_arr', $field_arr);
		}
	}
	public function pjActionGetCaptcha()
	{
	    $field = pjFormFieldModel::factory()->where('form_id', $_GET['id'])->where('`type`', 'captcha')->findAll()->getDataIndex(0);
	    $this->set('field', $field);
	    $this->setAjax(true);
	}
	public function pjActionSubmit()
	{
		$this->setAjax(true);
		$post_max_size = pjUtil::getPostMaxSize();
		if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_SERVER['CONTENT_LENGTH']) && (int) $_SERVER['CONTENT_LENGTH'] > $post_max_size)
		{
			echo '203';
			exit;
		}
		if(isset($_POST['id']))
		{
			$arr = pjFormModel::factory()->find($_POST['id'])->getData();
			$field_arr = pjFormFieldModel::factory()->where('form_id', $_POST['id'])->orderBy("order_id ASC")->findAll()->getData();

			if ($arr['status'] == 'F') {
				echo '205';
				exit;
			}

			$has_captcha = false;
			foreach($field_arr as $v)
			{
				if($v['type'] == 'captcha')
				{
					$has_captcha = true;
				}
			}
			if($has_captcha == true)
			{
				if (isset($this->option_arr['o_captcha_provider']) && $this->option_arr['o_captcha_provider'] == 'recaptcha')
				{
					$recaptcha_response = isset($_POST['g-recaptcha-response']) ? $_POST['g-recaptcha-response'] : '';
					if (!$this->pjVerifyRecaptcha($recaptcha_response))
					{
						echo '201';
						exit;
					}
				}else{
					if (!isset($_POST['captcha']))
					{
						echo '201';
						exit;
					}else{
						if(!pjCaptcha::validate($_POST['captcha'], $_SESSION[$this->defaultCaptcha . $_POST['id']]))
						{
							echo '201';
							exit;
						}
					}
				}
			}
			if($this->pjCheckUrls($field_arr, $_POST, $arr['reject_links']) == false)
			{
				echo '202';
				exit;
			}
			if($this->pjCheckBannedWords($field_arr, $_POST, $arr['block_words']) == false)
			{
				echo '200';
				exit;
			}
			if($this->pjCheckFileSize($field_arr, $_FILES) == false)
			{
				echo '204';
				exit;
			}
			
			$data = array();
			$data['form_id'] = $_POST['id'];
			$data['ip'] = $_SERVER['REMOTE_ADDR'];
			$id = pjSubmissionModel::factory($data)->insert()->getInsertId();
			
			if ($id !== false && (int) $id > 0)
			{
				$fields = '';
				$from = '';
				$email_arr = array();
				$drp_email_arr = array();
				$new_line = $arr['email_type'] == 'html' ? "<br />\n" : "\n";
				foreach($field_arr as $v){
					$pjSubmissionDetailModel = pjSubmissionDetailModel::factory();
					$data = array();
					$data['form_id'] = $_POST['id'];
					$data['submission_id'] = $id;
					$data['field_id'] = $v['id'];
					$data['type'] = $v['type'];
					
					$field_name = 'pjCF_field_' . $v['id'];
					
					switch ($v['type']) {
						case 'fileupload':
							if(isset($_FILES[$field_name]) && !empty($_FILES[$field_name]['tmp_name'])){
								$data['value'] = $this->pjActionUpload($_FILES[$field_name], $_POST['id'], $v['id'], $id, $v['extensions']);
							}
						break;
						case 'checkbox':
							if(isset($_POST[$field_name]))
							{
								$data['value'] = implode("|", $_POST[$field_name]);
							}else{
								$data['value'] = ':NULL';
							}
						break;
						case 'radio':
							if(isset($_POST[$field_name]))
							{
								$data['value'] = $_POST[$field_name];
							}else{
								$data['value'] = ':NULL';
							}
						break;
						case 'heading':
							$data['value'] = $v['label'];
						break;
						case 'button':
							$data['value'] = ':NULL';
						break;
						case 'captcha':
						break;
						default:
							$data['value'] = $_POST[$field_name];
							if($v['type'] == 'email' && $v['send_confirmation'] == 'T' && $_POST[$field_name] != ''){
								$email_arr[] = $_POST[$field_name];
							}
							if($v['type'] == 'email' && $_POST[$field_name] != ''){
								if($from == '')
								{
									$from = $_POST[$field_name];
								}
							}
							if($v['type'] == 'dropdown' && $_POST[$field_name] != ''){
								$row_arr = explode("|@|", $_POST[$field_name]);
								if(count($row_arr) == 2){
									$drp_email_arr[] = $row_arr[1];
									$data['value'] = $row_arr[0];
								}else{
									$data['value'] = $_POST[$field_name];
								}
							}
						break;
					}
					if($v['type'] != 'captcha' && $v['type'] != 'button')
					{
						if($v['type'] != 'heading'){
							if(isset($data['value']) && $data['value'] != ':NULL')
							{
								$fields .= $v['label'] . ': ' . str_replace("|", $new_line, $data['value']) . $new_line;
							}else{
								$fields .= $v['label'] . ': ' . $new_line;
							}
						}else{
							$fields .= $v['label'] . $new_line;
						}
					}
					$pjSubmissionDetailModel->reset()->setAttributes($data)->insert();
				}
				
				$pjEmail = new pjEmail();
				
				if ($this->option_arr['o_send_email'] == 'smtp')
				{
					$pjEmail
						->setTransport('smtp')
						->setSmtpHost($this->option_arr['o_smtp_host'])
						->setSmtpPort($this->option_arr['o_smtp_port'])
						->setSmtpSecure((isset($this->option_arr['o_smtp_secure']) && in_array($this->option_arr['o_smtp_secure'], array('ssl', 'tls'))) ? $this->option_arr['o_smtp_secure'] : '')
						->setSmtpUser($this->option_arr['o_smtp_user'])
						->setSmtpPass($this->option_arr['o_smtp_pass'])
						->setSmtpAuthType((isset($this->option_arr['o_smtp_auth']) && in_array($this->option_arr['o_smtp_auth'], array('CRAM-MD5', 'LOGIN', 'PLAIN', 'XOAUTH2'))) ? $this->option_arr['o_smtp_auth'] : 'LOGIN')
						->setSender($this->option_arr['o_smtp_user']);
				}
				
				$file_arr = pjFileModel::factory()->where('form_id', $_POST['id'])->where('submission_id', $id)->findAll()->getData();
				if(!empty($file_arr))
				{
					foreach($file_arr as $f)
					{
						$pjEmail->attach($f['file_path'], $f['file_name'], $f['mime_type']);
					}
				}
				$from_email = $this->getFromEmail($this->option_arr);
				if($from == '')
				{
					$from = $from_email;
				}

				$user_arr = pjUserFormModel::factory()->select('t1.user_id, t2.email')->join('pjUser', 't1.user_id=t2.id', 'left')->where('t1.form_id', $_POST['id'])->findAll()->getDataPair(null, 'email');

				if($fields != '' && $arr['subject'] != '' && $arr['message'] != ''){
					if($arr['email_type'] == 'html'){
						$pjEmail->setContentType('text/html');
					}else{
						$pjEmail->setContentType('text/plain');
					}
					$message = str_replace("{Fields}", $fields, $arr['message']);
					if(!empty($user_arr)){
						foreach($user_arr as $to_email){
							$pjEmail
							    ->setFrom($from_email)
								->setTo($to_email)
								->setSubject($arr['subject'])
								->send($message);
						}
					}
					if(!empty($drp_email_arr)){
						foreach($drp_email_arr as $v){
							$pjEmail
								->setFrom($from_email)
								->setTo($v)
								->setSubject($arr['subject'])
								->send($message);
						}
					}
				}
				if(!empty($email_arr) && $arr['auto_subject'] != '' && $arr['auto_message'] != ''){
					$pjEmail = new pjEmail();
					if ($this->option_arr['o_send_email'] == 'smtp')
					{
						$pjEmail
							->setTransport('smtp')
							->setSmtpHost($this->option_arr['o_smtp_host'])
							->setSmtpPort($this->option_arr['o_smtp_port'])
							->setSmtpSecure((isset($this->option_arr['o_smtp_secure']) && in_array($this->option_arr['o_smtp_secure'], array('ssl', 'tls'))) ? $this->option_arr['o_smtp_secure'] : '')
							->setSmtpUser($this->option_arr['o_smtp_user'])
							->setSmtpPass($this->option_arr['o_smtp_pass'])
							->setSmtpAuthType((isset($this->option_arr['o_smtp_auth']) && in_array($this->option_arr['o_smtp_auth'], array('CRAM-MD5', 'LOGIN', 'PLAIN', 'XOAUTH2'))) ? $this->option_arr['o_smtp_auth'] : 'LOGIN')
							->setSender($this->option_arr['o_smtp_user']);
					}
					
					if($arr['email_type'] == 'html'){
						$pjEmail->setContentType('text/html');
					}else{
						$pjEmail->setContentType('text/plain');
					}
					foreach($email_arr as $email){
						$pjEmail->setFrom($from_email)
								->setTo($email)
								->setSubject($arr['auto_subject'])
								->send($arr['auto_message']);
					}
				}
				
				$_SESSION[$this->defaultCaptcha] = NULL;
				unset($_SESSION[$this->defaultCaptcha]);
			}
			echo '100';
		}
		exit;
	}
	
	public function pjActionDownloadFile()
	{
		$id = pjObject::escapeString($_GET['id']);
		$arr = pjFileModel::factory()->find($id)->getData();
		if(!empty($arr))
		{
			if($arr['hash'] == $_GET['hash'])
			{
				pjToolkit::download(@file_get_contents(PJ_INSTALL_PATH . $arr['file_path']), $arr['file_name'], $arr['mime_type']);
			}else{
				__('front_file_not_found');
			}
		}else{
			__('front_file_not_found');
		}
		exit;
	}
	
	public function pjActionCheckFormStatus()
	{
		$this->setAjax(true);

		$status = 'F';
		if ($this->isXHR()) {
			$form = pjFormModel::factory()->find($_GET['id'])->getData();
			if ($form) {
				$status = $form['status'];
			}
		}

		self::jsonResponse(array('status' => $status));
	}
	
	private function pjActionUpload($file_arr, $form_id, $field_id, $submission_id, $ext)
	{
		$files = array();
		$field_name_arr = array();
		if(is_array($file_arr['name']))
		{
			foreach ($file_arr as $k => $l) 
			{
				foreach ($l as $i => $v) 
				{
			 		if (!array_key_exists($i, $files))
			 		{
			   			$files[$i] = array();
			 		}
			   		$files[$i][$k] = $v;
			 	}
			}
		}else{
			$files[0] = $file_arr;
		}
		
		$pjFileModel = pjFileModel::factory();
		foreach ($files as $file) {
			$data = array();
			$data['form_id'] = $form_id;
			$data['field_id'] = $field_id;
			$data['submission_id'] = $submission_id;
			$handle = new pjUpload();
			if(!empty($ext))
			{
				$handle->setAllowedExt(explode("|", $ext));
			}
			if ($handle->load($file)) {
				$hash = md5(uniqid(rand(), true));
				$file_ext = $handle->getExtension();
				$file_path = PJ_UPLOAD_PATH . 'files/' . $form_id . "_" . $field_id . '_' . $hash . '.' . $file_ext;
				if($handle->save($file_path))
				{
					$data['file_path'] = $file_path;
					$data['file_name'] = $file['name'];
					$data['mime_type'] = $file['type'];
					$data['hash'] = $hash;
		
					$pjFileModel->reset()->setAttributes($data)->insert();
						
					$field_name_arr[] = $file['name'];
				}
			}
		}
		return implode("|", $field_name_arr);
	}
	
	private function pjVerifyRecaptcha($response)
	{
		$secret = isset($this->option_arr['o_recaptcha_secret_key']) ? trim($this->option_arr['o_recaptcha_secret_key']) : '';
		if ($secret == '' || $response == '')
		{
			return false;
		}
		$data = array(
			'secret'   => $secret,
			'response' => $response,
			'remoteip' => $_SERVER['REMOTE_ADDR']
		);
		$url = 'https://www.google.com/recaptcha/api/siteverify';
		$result = false;
		if (function_exists('curl_init'))
		{
			$ch = curl_init();
			curl_setopt($ch, CURLOPT_URL, $url);
			curl_setopt($ch, CURLOPT_POST, true);
			curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($data));
			curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
			curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, true);
			curl_setopt($ch, CURLOPT_TIMEOUT, 20);
			$result = curl_exec($ch);
			curl_close($ch);
		}
		// Fall back to the stream wrapper if cURL is unavailable or failed
		// (e.g. a server whose cURL has no CA bundle configured).
		if ($result === false || $result === '' || $result === null)
		{
			$context = stream_context_create(array(
				'http' => array(
					'method'  => 'POST',
					'header'  => "Content-type: application/x-www-form-urlencoded\r\n",
					'content' => http_build_query($data),
					'timeout' => 20
				)
			));
			$result = @file_get_contents($url, false, $context);
		}
		if ($result === false || $result === '')
		{
			return false;
		}
		$json = json_decode($result, true);
		return (isset($json['success']) && $json['success'] == true);
	}

	private function pjCheckBannedWords($field_arr, $post, $banned_words)
	{
		$result = true;
		if($banned_words != ''){
			$banned_arr = explode("\r\n", $banned_words);
			foreach($banned_arr as $k => $v){
				$banned_arr[$k] = trim($v);
			}
			foreach($field_arr as $v){
				if($v['type'] == 'textbox' || $v['type'] == 'textarea'){
					$field_name = 'pjCF_field_' . $v['id'];
					$string = $post[$field_name];
					$matches = array();
					$matchFound = preg_match_all("/\b(" . implode($banned_arr,"|") . ")\b/i", $string, $matches);
					if ($matchFound) {
						$result = false;
					}
				}
			}
		}
		return $result;
	}
	
	private function pjCheckUrls($field_arr, $post, $reject)
	{
		$result = true;
		if($reject == 'T'){
			$reg_exUrl = "/(http|https|ftp|ftps)\:\/\/[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}(\/\S*)?/";
			foreach($field_arr as $v){
				if(($v['type'] == 'textbox' && $v['validation'] != 'url') || $v['type'] == 'textarea'){
					$field_name = 'pjCF_field_' . $v['id'];
					$string = $post[$field_name];
					if(preg_match($reg_exUrl, $string, $url)) {
						$result = false;
					}
				}
			}
		}
		return $result;
	}
	
	private function pjCheckFileSize($field_arr, $FILES)
	{
		$result = true;
		$files = array();
		foreach($field_arr as $v){
			if($v['type'] == 'fileupload')
			{
				$field_name = 'pjCF_field_' . $v['id'];
				$file_arr = $FILES[$field_name];
				if(is_array($file_arr['name']))
				{
					foreach ($file_arr as $k => $l)
					{
						foreach ($l as $i => $v)
						{
							if (!array_key_exists($i, $files))
							{
								$files[$i] = array();
							}
							$files[$i][$k] = $v;
						}
					}
				}else{
					$files[0] = $file_arr;
				}
				foreach ($files as $file)
				{
					if($file['error'] != 4 && $file['error'] != 0)
					{
						$result = false;
					}
				}
			}
		}
		return $result;
	}
}
?>