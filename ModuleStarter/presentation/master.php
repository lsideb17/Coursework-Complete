<?php
class Master
{
	// Define the template file for the page contents
	public $mContents;
	public $mSideBar;
	public $currentPage;

	// Class constructor
	public function __construct()
	{
		$this->currentPage = $_SESSION['CurrentPage'];
	}

	// Initialize presentation object
	public function init()
	{
		// Load the database handler
		require_once BUSINESS_DIR . 'database_handler.php';

		// Load Business Tier
		require_once BUSINESS_DIR . 'business.php';


 		if ($this->currentPage == 'Home' || $this->currentPage == 'Modules' || $this->currentPage == 'Filter' || $this->currentPage == 'Search')
		{
			$this->mContents = 'modules_set.tpl';
			if ($this->currentPage == 'Home')
				$this->mSideBar = 'categories_list.tpl';
			else
				$this->mSideBar = 'categories_list.tpl';
		}
		elseif ($this->currentPage == 'Details')
		{
			$this->mContents = 'module_details.tpl';
			$this->mSideBar = 'categories_list.tpl';
		}
		elseif ($this->currentPage == 'Random')
		{
			$this->mContents = 'random_module.tpl';
			$this->mSideBar = 'categories_list.tpl';
		}
		
		elseif ($this->currentPage == 'ModuleLeaders')
		{
			$this->mContents = 'module_leaders_list.tpl';
			$this->mSideBar = 'categories_list.tpl';
		}
	}
}
?>
