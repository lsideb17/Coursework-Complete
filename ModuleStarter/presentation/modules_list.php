<?php
	class ModulesList
	{
		// Public variables to be read from Smarty template
		public $mModules;
		public $mCurrentPage;
		public $mModuleID;

		// Class constructor
		public function __construct()
		{
			$this->mCurrentPage = $_SESSION['CurrentPage'];
 		}

		public function init()
		{
			$this->mModules = Business::GetRandomModules();
		}
	}
?>
