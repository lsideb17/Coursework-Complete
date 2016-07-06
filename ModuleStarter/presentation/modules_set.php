<?php
	class ModulesSet
	{
		// Public variables to be read from Smarty template
		public $mModules;
		public $mCurrentPage;
		public $mPage = 1;
		public $mrTotalPages;
		public $mLinkToNextPage;
		public $mLinkToPreviousPage;
		public $mModuleListPages = array();
		public $mModuleCategory;
		public $mModuleLeader;
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
			   $this->mModuleCategory = $_GET['category'];
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
				if ($this->mCurrentPage == 'Modules')
				{
				$this->mModules = Business::GetModulesInCollection($this->mPage, $this->mrTotalPages);
				$basicURL = '?op=' . $_SESSION['CurrentPage'];
				}
				elseif ($this->mCurrentPage == 'Filter')
			    {
				    if (isset ($this->mSearchString))
				    {
					   $this->mModules = Business::GetModulesByCategorySearch($this->mSearchString, $this->mModuleCategory, $this->mPage, $this->mrTotalPages);
				 	   $basicURL = '?op=' . $_SESSION['CurrentPage'] . '&category=' . $this->mModuleCategory . '&searchText=' . $this->mSearchString;
				    }
					
				    else
				    {
					   $this->mModules = Business::GetModulesByCategory($this->mModuleCategory, $this->mPage, $this->mrTotalPages);
					   $basicURL = '?op=' . $this->mCurrentPage . '&category=' . $this->mModuleCategory;
				    }
			    }
			    elseif ($this->mCurrentPage == 'Search')
				{
				   $this->mModules = Business::Search($this->mSearchString, $this->mPage, $this->mrTotalPages);
				   $basicURL = '?op=' . $this->mCurrentPage . '&searchText=' . $this->mSearchString;
				}
				
				
			}
			elseif ($this->mCurrentPage == 'Home')
			{
				$this->mModules = Business::GetRandomModules();
				
			}
			/* If there are sub pages of albums, display navigation controls */
			if ($this->mrTotalPages > 1)
			{
			   // Build the Next link
			   if ($this->mPage < $this->mrTotalPages)
			   {
			      $nextPage = $this->mPage + 1;
			      $this->mLinkToNextPage =
			             $basicURL. '&Page=' . $nextPage;
			   }

			   // Build the Previous link
			   if ($this->mPage > 1)
			   {
			      $prevPage = $this->mPage - 1;
			      $this->mLinkToPreviousPage =
			             $basicURL. '&Page=' . $prevPage;
			   }

			   // Build the pages links
			   for ($i = 1; $i <= $this->mrTotalPages; $i++)
			      $this->mModuleListPages[] = $basicURL. '&Page=' . $i;
			}
		}
	}
?>
