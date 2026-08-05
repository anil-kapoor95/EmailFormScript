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
				
				if (isset($_POST['next_action']))
				{
					switch ($_POST['next_action'])
					{
						case 'pjActionIndex':
							$err = 'AO01';
							break;
					}
				}
				pjUtil::redirect($_SERVER['PHP_SELF'] . "?controller=pjAdminOptions&action=" . @$_POST['next_action'] . "&err=$err");
			}
		} else {
			$this->set('status', 2);
		}
	}
}
?>