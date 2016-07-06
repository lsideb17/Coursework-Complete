<?php
	class RandomModule
	{
		// Public variables to be read from Smarty template
		public $mRandomModule;
		public $mCurrentPage;
		public $mPage = 1;
		public $mrTotalPages;
		public $mCategory;
		public $mSearchString;

		// Class constructor
		public function __construct()
		{
			$this->mCurrentPage = $_SESSION['CurrentPage'];
			// Get Page number from query string casting it to int
			if (isset ($_GET['Page']))
			{
			   $this->mPage = (int)$_GET['Page'];
			}
			// Get Category from query string
			if (isset ($_GET['category']))
			{
			   $this->mCategory = $_GET['category'];
			}
			// Retrieve search string from query string or posted form
			if ($this->mCurrentPage == 'Search' || $this->mCurrentPage == 'Filter')
			{
			    if (isset ($_GET['searchText']))
			       $this->mSearchString = $_GET['searchText'];
			    elseif (isset ($_POST['searchText']))
			       $this->mSearchString = trim($_POST['searchText']);
			}
		}
		
		public function init()
		{
			if ($this->mCurrentPage == 'Modules' || $this->mCurrentPage == 'Filter' || $this->mCurrentPage == 'Search')
			{
				if ($this->mCurrentPage == 'Random')
				{
				$this->mRandomModule = Business::GetModulesInCollection($this->mPage, $this->mrTotalPages);
				$basicURL = '?op=' . $_SESSION['CurrentPage'];
				}
				elseif ($this->mCurrentPage == 'Filter')
			    {
				   if (isset ($this->mSearchString))
				    {
					   $this->mRandomModule = Business::GetModulesByCategorySearch($this->mSearchString, $this->mCategory, $this->mPage, $this->mrTotalPages);
				 	   $basicURL = '?op=' . $_SESSION['CurrentPage'] . '&category=' . $this->mCategory . '&searchText=' . $this->mSearchString;
				    }
				    else
				    {
					 $this->mRandomModule = Business::GetModulesByCategory($this->mCategory, $this->mPage, $this->mrTotalPages);
					  $basicURL = '?op=' . $this->mCurrentPage . '&category=' . $this->mCategory;
				    }
			    }
			    elseif ($this->mCurrentPage == 'Search')
				{
				   $this->mRandomModule = Business::Search($this->mSearchString, $this->mPage, $this->mrTotalPages);
				   $basicURL = '?op=' . $this->mCurrentPage . '&searchText=' . $this->mSearchString;
				}
			}
			
			elseif ($this->mCurrentPage == 'Random')
			{
				$this->mRandomModule = Business::GetRandom();
				
			}
			
		}
	}
?>
