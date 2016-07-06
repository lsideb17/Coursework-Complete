<?php
class AdminModule
{
	public $mModuleID;
	public $mModule;
	public $mErrorMessage;
	public $mModuleLeader;
	public $mModuleLeaders;
	public $mModules;
	public $mModuleTitle;
	public $mImage;
	public $mModuleCategory;
	public $mModuleDescription;
	public $mKeyword;
	public $mLoggedIn;
	public $mUpdateButtonDisplay;
	public $mAddButtonDisplay=TRUE;
	// public $mAddKeywordToModule;
	
	// Private members
	private $mAction;
	
		// Class constructor
	public function __construct()
	{
		// Load the database handler
		require_once BUSINESS_DIR . 'database_handler.php';

		// Load Business Tier
		require_once BUSINESS_DIR . 'business.php';

		$this->mAction = 'None';
		if (isset ($_GET['Page']) && ($_GET['Page'] == 'Logout'))
		{
			unset($_SESSION['adminmodule_logged']);
			header('Location: adminmodule.php');
			exit();
		}
		elseif (isset ($_POST['submit_add']))
		{
			$this->mAction = 'AddModule';
			$this->mAddButtonDisplay = TRUE;
			$this->mUpdateButtonDisplay = FALSE;
		}
		elseif (isset ($_POST['submit_edit']))
		{
			$this->mAction = 'EditModule';
			$this->mAddButtonDisplay = TRUE;
			$this->mUpdateButtonDisplay = FALSE;
		}
		/*elseif (isset ($_POST['submit_add_keyword']))
		{
			$this->mAction = 'AddKeywordToModule';
			$this->mAddKeywordButtonDisplay = TRUE;
			$this->mUpdateButtonDisplay = FALSE;
		}*/
		elseif (isset ($_POST['submit_select_module_leader']))
		{
			$this->mAction = 'SelectModuleLeader';
			$this->mAddButtonDisplay = TRUE;
			$this->mUpdateButtonDisplay = FALSE;
		}
		elseif (isset ($_POST['submit_select_module']))
		{
			$this->mAction = 'SelectModule';
			$this->mUpdateButtonDisplay = TRUE;
			$this->mAddButtonDisplay = FALSE;
		}
		if (isset ($_SESSION['adminmodule_logged']))
		{
			$this->mLoggedIn = TRUE;
		}
	}

	public function init()
	{
	$this->mModuleLeaders = Business::GetModuleLeaders(); // to populate Select Leader drop down list

		if ($this->mAction == 'AddModule' || $this->mAction == 'EditModule')	// Add or Update request
		{
			$this->mModuleID = $_POST['module_id'];
			$this->mModuleTitle = $_POST['new_module_title'];
			$this->mModuleLeader = $_POST['new_module_leader'];
			$this->mImage = $_POST['new_image'];
			$this->mModuleCategory = $_POST['new_module_category'];
			$this->mModuleDescription = $_POST['new_module_description'];
			$this->mKeyword = $_POST['new_keyword'];

							
			if ($this->mModuleTitle == null)
				$this->mErrorMessage = 'Module title required';

			if ($this->mModuleLeader == null)
				$this->mErrorMessage = 'Leader required';

			if ($this->mImage == null)
				$this->mErrorMessage = 'Image required';
			
			if ($this->mModuleCategory == null)
				$this->mErrorMessage = 'Category required';
				
			if ($this->mModuleDescription == null)
				$this->mErrorMessage = 'Description required';
				
			if ($this->mKeyword == null)
				$this->mErrorMessage = 'Keywords required';	
				
			if ($this->mErrorMessage == null)
			{
				if ($this->mAction == 'AddModule')
				{
				 Business::AddModule($this->mModuleTitle, 
					$this->mModuleLeader, 
					$this->mModuleDescription, 
					$this->mImage, 
					$this->mModuleCategory);
				
					
					// Complete this line with a call to a Collection class method
				}
				/*if ($this->mAction == 'AddKeywordToModule')
				{	
					Business::AddKeywordToModule($this->mModuleId, 
					$this->mKeywordId);
				}*/
				else
				{
					Business::UpdateModule($this->mModuleID,
					$this->mModuleLeader,
					$this->mModuleTitle, 
					$this->mModuleDescription, 
					$this->mImage, 
					$this->mModuleCategory);
					// Complete this line with a call to a Collection class method
				}
				header('Location: moduleadmin.php');
			}
		}
		elseif ($this->mAction == 'SelectModuleLeader')
		{
			 $this->mModuleLeader = $_POST['module_leaders'];
			 $this->mModuleID = '';
			 $this->mModuleTitle = '[module_title]';
			 $this->mImage = '[module_image]';
			 $this->mModuleCategory = '[module_category]';
			 $this->mModuleDescription = '[module_description]';
			 $this->mKeyword = '[keyword]';
			 
			 
			 $this->mModules = Business::GetModuleLeaderModules($this->mModuleLeader);
			
			// Insert the code to call a Collection class method and populate the attributes required to populate the Update form
		}
		elseif ($this->mAction == 'SelectModule')
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
		
		/*elseif ($this->mAction == 'AddKeywordToModule')
		{
				$this->mModuleID = $_POST['module_id'];
				$this->mKeywordID = $_POST['new_keyword_id'];
			
					
		}*/
		else
		{
			$this->mModuleID = '';
			$this->mModuleTitle = '[module_title]';
			$this->mModuleLeader = '[module_leader]';
			$this->mImage = '[module_image]';
			$this->mModuleCategory = '[module_category]';
			$this->mModuleDescription = '[module_description]';
			 $this->mKeyword = '[keyword]';
		}
	
	}
}

?>