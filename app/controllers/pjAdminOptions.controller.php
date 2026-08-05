<?php
if (!defined("ROOT_PATH"))
{
	header("HTTP/1.1 403 Forbidden");
	exit;
}
class pjAdminOptions extends pjAdmin
{
	public function pjActionIndex()
	{
		$this->checkLogin();

		if ($this->isAdmin())
		{
			$arr = pjOptionModel::factory()
				->where('t1.foreign_id', $this->getForeignId())
				->orderBy('t1.order ASC')
				->findAll()
				->getData();

			$this->set('arr', $arr);
			$this->appendJs('jquery.tipsy.js', PJ_THIRD_PARTY_PATH . 'tipsy/');
			$this->appendCss('jquery.tipsy.css', PJ_THIRD_PARTY_PATH . 'tipsy/');
			$this->appendJs('pjAdminOptions.js');
		} else {
			$this->set('status', 2);
		}
	}

	/**
	 * Email Settings screen (mail transport, SMTP configuration,
	 * test connection & send test email).
	 */
	public function pjActionEmailSettings()
	{
		$this->checkLogin();

		if ($this->isAdmin())
		{
			$this->appendJs('jquery.tipsy.js', PJ_THIRD_PARTY_PATH . 'tipsy/');
			$this->appendCss('jquery.tipsy.css', PJ_THIRD_PARTY_PATH . 'tipsy/');
			$this->appendJs('pjAdminOptions.js');
		} else {
			$this->set('status', 2);
		}
	}

	public function pjActionUpdate()
	{
		$this->checkLogin();

		if ($this->isAdmin())
		{
			if (isset($_POST['options_update']))
			{
				// When Google reCAPTCHA is selected, both keys are required.
				if (isset($_POST['value-enum-o_captcha_provider']))
				{
					$provider_parts = explode('::', $_POST['value-enum-o_captcha_provider']);
					$provider_val = isset($provider_parts[1]) ? $provider_parts[1] : '';
					if ($provider_val === 'recaptcha')
					{
						$site_key = isset($_POST['value-string-o_recaptcha_site_key']) ? trim($_POST['value-string-o_recaptcha_site_key']) : '';
						$secret_key = isset($_POST['value-string-o_recaptcha_secret_key']) ? trim($_POST['value-string-o_recaptcha_secret_key']) : '';
						if ($site_key === '' || $secret_key === '')
						{
							pjUtil::redirect($_SERVER['PHP_SELF'] . "?controller=pjAdminOptions&action=" . @$_POST['next_action'] . "&err=AO02");
							return;
						}
					}
				}

				$OptionModel = new pjOptionModel();

				foreach ($_POST as $key => $value)
				{
					if (preg_match('/value-(string|text|int|float|enum|bool|color)-(.*)/', $key) === 1)
					{
						list(, $type, $k) = explode("-", $key);
						if (!empty($k))
						{
							$OptionModel
								->reset()
								->where('foreign_id', $this->getForeignId())
								->where('`key`', $k)
								->limit(1)
								->modifyAll(array('value' => $value));
						}
					}
				}

				$next_action = isset($_POST['next_action']) ? $_POST['next_action'] : 'pjActionIndex';

				if ($next_action === 'pjActionEmailSettings')
				{
					pjUtil::redirect($_SERVER['PHP_SELF'] . "?controller=pjAdminOptions&action=pjActionEmailSettings&saved=1");
					return;
				}

				$err = '';
				switch ($next_action)
				{
					case 'pjActionIndex':
						$err = 'AO01';
						break;
				}
				pjUtil::redirect($_SERVER['PHP_SELF'] . "?controller=pjAdminOptions&action=" . $next_action . "&err=$err");
			}
		} else {
			$this->set('status', 2);
		}
	}

	/**
	 * AJAX: test an SMTP connection using the values currently entered
	 * in the Email Settings form (nothing is saved).
	 */
	public function pjActionAjaxSmtp()
	{
		$this->setAjax(true);

		if (!$this->isXHR())
		{
			pjAppController::jsonResponse(array('status' => 'ERR', 'code' => 100, 'text' => 'Invalid request.'));
		}

		if (!(isset($_SERVER['REQUEST_METHOD']) && $_SERVER['REQUEST_METHOD'] === 'POST'))
		{
			pjAppController::jsonResponse(array('status' => 'ERR', 'code' => 101, 'text' => 'Invalid request method.'));
		}

		if (!$this->isAdmin())
		{
			pjAppController::jsonResponse(array('status' => 'ERR', 'code' => 103, 'text' => 'Forbidden.'));
		}

		$host   = isset($_POST['smtp_host'])   ? trim($_POST['smtp_host'])   : '';
		$port   = isset($_POST['smtp_port'])   ? trim($_POST['smtp_port'])   : '';
		$user   = isset($_POST['smtp_user'])   ? trim($_POST['smtp_user'])   : '';
		$pass   = isset($_POST['smtp_pass'])   ? (string) $_POST['smtp_pass'] : '';
		$secure = isset($_POST['smtp_secure']) ? trim($_POST['smtp_secure']) : '';
		$auth   = isset($_POST['smtp_auth'])   ? trim($_POST['smtp_auth'])   : 'LOGIN';

		if (empty($host) || empty($port))
		{
			pjAppController::jsonResponse(array('status' => 'ERR', 'code' => 102, 'text' => __('emailMsgEnterHostPort', true)));
		}

		$message = '';
		$result  = false;

		try {
			$mail = new pjPHPMailer(true);
			$mail->isSMTP();
			$mail->Timeout = 10;
			$mail->Host = str_ireplace(array('ssl://', 'tls://'), array('', ''), $host);
			$mail->Port = (int) $port;
			if (in_array($secure, array('ssl', 'tls')))
			{
				$mail->SMTPSecure = $secure;
			}
			if (!empty($user))
			{
				$mail->SMTPAuth = true;
				$mail->AuthType = in_array($auth, array('CRAM-MD5', 'LOGIN', 'PLAIN', 'XOAUTH2')) ? $auth : 'LOGIN';
				$mail->Username = $user;
				$mail->Password = $pass;
			}
			$result = $mail->smtpConnect();
			$mail->smtpClose();
		} catch (Exception $e) {
			$result  = false;
			$message = $e->getMessage();
		}

		if ($result)
		{
			pjAppController::jsonResponse(array('status' => 'OK', 'code' => 200, 'text' => __('emailMsgConnOk', true)));
		}

		pjAppController::jsonResponse(array('status' => 'ERR', 'code' => 104, 'text' => __('emailMsgConnFail', true) . (!empty($message) ? ' (' . $message . ')' : '')));
	}

	/**
	 * AJAX: send a test email using the values currently entered
	 * in the Email Settings form (nothing is saved).
	 */
	public function pjActionAjaxSend()
	{
		$this->setAjax(true);

		if (!$this->isXHR())
		{
			pjAppController::jsonResponse(array('status' => 'ERR', 'code' => 100, 'text' => 'Invalid request.'));
		}

		if (!(isset($_SERVER['REQUEST_METHOD']) && $_SERVER['REQUEST_METHOD'] === 'POST'))
		{
			pjAppController::jsonResponse(array('status' => 'ERR', 'code' => 101, 'text' => 'Invalid request method.'));
		}

		if (!$this->isAdmin())
		{
			pjAppController::jsonResponse(array('status' => 'ERR', 'code' => 103, 'text' => 'Forbidden.'));
		}

		$email = isset($_POST['email']) ? trim($_POST['email']) : '';
		if (empty($email) || !preg_match('/^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$/i', $email))
		{
			pjAppController::jsonResponse(array('status' => 'ERR', 'code' => 102, 'text' => __('emailMsgEnterValidEmail', true)));
		}

		$method     = isset($_POST['send_email'])  ? trim($_POST['send_email'])  : 'mail';
		$host       = isset($_POST['smtp_host'])   ? trim($_POST['smtp_host'])   : '';
		$port       = isset($_POST['smtp_port'])   ? trim($_POST['smtp_port'])   : '';
		$user       = isset($_POST['smtp_user'])   ? trim($_POST['smtp_user'])   : '';
		$pass       = isset($_POST['smtp_pass'])   ? (string) $_POST['smtp_pass'] : '';
		$secure     = isset($_POST['smtp_secure']) ? trim($_POST['smtp_secure']) : '';
		$auth       = isset($_POST['smtp_auth'])   ? trim($_POST['smtp_auth'])   : 'LOGIN';
		$from_name  = isset($_POST['from_name'])   ? trim($_POST['from_name'])   : '';
		$from_email = isset($_POST['from_email']) && !empty($_POST['from_email'])
			? trim($_POST['from_email'])
			: $this->getFromEmail($this->option_arr);

		$pjEmail = new pjEmail();
		if ($method === 'smtp')
		{
			$pjEmail
				->setTransport('smtp')
				->setSmtpHost($host)
				->setSmtpPort($port)
				->setSmtpSecure(in_array($secure, array('ssl', 'tls')) ? $secure : '')
				->setSmtpUser($user)
				->setSmtpPass($pass)
				->setSmtpAuthType(in_array($auth, array('CRAM-MD5', 'LOGIN', 'PLAIN', 'XOAUTH2')) ? $auth : 'LOGIN')
				->setSender(!empty($user) ? $user : $from_email);
		}

		$subject = 'Test email from Email Form Script';
		$body    = 'Congratulations! This is a test message sent from the Email Settings page of your Email Form Script. '
				 . 'If you have received this email, your email settings are working correctly.';

		$pjEmail->setContentType('text/html');

		$ok = $pjEmail
			->setFrom($from_email, $from_name)
			->setTo($email)
			->setSubject($subject)
			->send($body);

		if ($ok)
		{
			pjAppController::jsonResponse(array('status' => 'OK', 'code' => 200, 'text' => __('emailMsgSentOk', true) . ' ' . $email . '. ' . __('emailMsgCheckInbox', true)));
		}

		$err = $pjEmail->getErrorMessage();
		pjAppController::jsonResponse(array('status' => 'ERR', 'code' => 104, 'text' => __('emailMsgSendFail', true) . (!empty($err) ? ' (' . $err . ')' : '')));
	}
}
?>
