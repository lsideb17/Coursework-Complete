<?php
// Reference Smarty library
require_once SMARTY_DIR . 'Smarty.class.php';

// Class extends Smarty, used to process and display Smarty files

class Application extends Smarty
{
	// Class constructor
	public function __construct()
	{
		// Call Smarty's constructor
		parent::__construct();
		
		// Change the default template directories
		$this->setTemplateDir(TEMPLATE_DIR);
		$this->setCompileDir(COMPILE_DIR);
		$this->setConfigDir(CONFIG_DIR);
		$this->addPluginsDir(SMARTY_DIR . 'plugins');
		$this->addPluginsDir(PRESENTATION_DIR . 'smarty_plugins');
		$this->muteExpectedErrors();	

	}
}

?>
