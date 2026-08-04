<?php
if (!defined("ROOT_PATH"))
{
	header("HTTP/1.1 403 Forbidden");
	exit;
}
require_once ROOT_PATH . 'core/framework/components/pjToolkit.component.php';
class pjUtil extends pjToolkit
{
	static public function getDateFormat()
	{
		return array(
			'd.m.Y' => 'd.m.Y (25.09.2012)',
			'm.d.Y' => 'm.d.Y (09.25.2012)',
			'Y.m.d' => 'Y.m.d (2012.09.25)',
			'j.n.Y' => 'j.n.Y (25.9.2012)',
			'n.j.Y' => 'n.j.Y (9.25.2012)',
			'Y.n.j' => 'Y.n.j (2012.9.25)',
			'd/m/Y' => 'd/m/Y (25/09/2012)',
			'm/d/Y' => 'm/d/Y (09/25/2012)',
			'Y/m/d' => 'Y/m/d (2012/09/25)',
			'j/n/Y' => 'j/n/Y (25/9/2012)',
			'n/j/Y' => 'n/j/Y (9/25/2012)',
			'Y/n/j' => 'Y/n/j (2012/9/25)',
			'd-m-Y' => 'd-m-Y (25-09-2012)',
			'm-d-Y' => 'm-d-Y (09-25-2012)',
			'Y-m-d' => 'Y-m-d (2012-09-25)',
			'j-n-Y' => 'j-n-Y (25-9-2012)',
			'n-j-Y' => 'n-j-Y (9-25-2012)',
			'Y-n-j' => 'Y-n-j (2012-9-25)'
		);
	}
	
	static public function getFontSizes()
	{
		return array(
			'8' => '8',
			'10' => '10',
			'11' => '11',
			'12' => '12',
			'14' => '14',
			'16' => '16',
			'18' => '18',
			'20' => '20',
			'22' => '22',
			'24' => '24'
		);
	}
	
	static public function getFields()
	{
		return array(
			'heading' => 'Heading',
			'textbox' => 'Text Box',
			'email' => 'Email',
			'textarea' => 'Text Area',
			'dropdown' => 'Drop Down',
			'radio' => 'Radio Button',
			'checkbox' => 'Check Box',
			'fileupload' => 'File Upload',
			'datepicker' => 'Date Picker',
			'captcha' => 'Captcha',
			'button' => 'Submit Button'
		);
	}
	
	static public function getFonts()
	{
		return array(
			'Arial' => 'Arial',
			'Courier' => 'Courier',
			'Courier New' => 'Courier New',
			'Comic Sans MS' => 'Comic Sans MS',
			'Gill Sans' => 'Gill Sans',
			'Helvetica' => 'Helvetica',
			'Lucida' => 'Lucida',
			'Lucida Grande' => 'Lucida Grande',
			'Trebuchet MS' => 'Trebuchet MS',
			'Tahoma' => 'Tahoma',
			'Times New Roman' => 'Times New Roman',
			'Verdana' => 'Verdana'
		);
	}
	
	public static function printInstallNotice($title, $body, $convert = true, $close = true)
	{
		?>
		<div class="install-notice-box">
			<div class="notice-top"></div>
			<div class="notice-middle">
				<span class="notice-info">&nbsp;</span>
				<?php
				if (!empty($title))
				{
					printf('<span class="block bold">%s</span>', $convert ? htmlspecialchars(stripslashes($title)) : stripslashes($title));
				}
				if (!empty($body))
				{
					printf('<span class="block">%s</span>', $convert ? htmlspecialchars(stripslashes($body)) : stripslashes($body));
				}
				if ($close)
				{
					?><a href="#" class="notice-close"></a><?php
				}
				?>
			</div>
			<div class="notice-bottom"></div>
		</div>
		<?php
	}
	
	public static function addHttp($url) {
	    if (!preg_match("~^(?:f|ht)tps?://~i", $url)) {
	        $url = "http://" . $url;
	    }
	    return $url;
	}
	
	public static function getPostMaxSize()
	{
		$post_max_size = ini_get('post_max_size');
		switch (substr($post_max_size, -1))
		{
			case 'G':
				$post_max_size = (int) $post_max_size * 1024 * 1024 * 1024;
				break;
			case 'M':
				$post_max_size = (int) $post_max_size * 1024 * 1024;
				break;
			case 'K':
				$post_max_size = (int) $post_max_size * 1024;
				break;
		}
		return $post_max_size;
	}
}
?>