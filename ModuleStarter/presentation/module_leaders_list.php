<?php
	class ModuleLeadersList
	{
		// Public variables to be read from Smarty template
		public $mModuleLeadersList;
		public $mLeadersModules = array(array());
		public $mModuleID;
		
		
		// Class constructor
		public function __construct()
		{
			$mLeadersModules;
 		}

		public function init()
		{
			$this->mModuleLeadersList = Business::GetModuleLeaders();
			for ($i = 0; $i < count($this->mModuleLeadersList); $i++)  
			{
				$this->mLeadersModules[$i] = Business::GetModuleLeaderModules($this->mModuleLeadersList[$i]['module_leader']);	
				
			}
		}
	}
?>