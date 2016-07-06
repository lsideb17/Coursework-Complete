<?php
	class ModuleDetails
	{
		// Public variables to be read from Smarty template
		public $mModuleID;
		public $mModule;
		public $mKeyword;
		public $mDeleteButtonDisplay;
		
		private $mAction;
				
		// Class constructor
		public function __construct()
		{
			if (isset($_GET['module_id']))
			{
				$this->mModuleID = $_GET['module_id'];
			}
			elseif (isset ($_POST['delete_module']))
			{
			$this->mAction = 'DeleteModule';
			$this->mDeleteButtonDisplay = TRUE;
			}
 		}

		public function init()
		{
			$this->mModule = Business::GetModuleDetails($this->mModuleID);
			
			$this->mKeyword = Business::GetModuleKeywords($this->mModuleID);
			
			if ($this->mAction == 'DeleteModule')
			{
			 $this->mModuleLeader = $_POST['module_leader'];
			 $this->mModuleID = $_POST['modules'];
			 $this->mModuleTitle = ['module_title'];
			 $this->mImage = $this->mModule['module_image'];
			 $this->mModuleCategory = $this->mModule['module_category'];
			 $this->mModuleDescription = $this->mModule['module_description'];
			 $this->mKeyword = '[keyword]';
			 $this->mModule = Business::GetModuleLeaderModules($this->mModule);
			
			// Insert the code to call a Collection class method and populate the attributes required to populate the Update form
			}
		}
		
	}		
		
	
?>