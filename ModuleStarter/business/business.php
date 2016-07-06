<?php
// Business tier class for reading module and student information

class Business
{
	// Retrieves all modules
	public static function GetModules()
	{
		// Build SQL query
		$sql = 'CALL get_modules_list()';

		// Execute the query and return the results
		return DatabaseHandler::GetAll($sql);
	}

	// Retrieves latest modules
	public static function GetLatestModules()
	{
		// Build SQL query
		$sql = 'CALL get_modules_latest()';

		// Execute the query and return the results
		return DatabaseHandler::GetAll($sql);
	}

		// Retrieves module details
	public static function GetModuleDetails($moduleId)
	{
		// Build SQL query
		$sql = 'CALL get_module_details(:module_id)';

		// Build the parameters array
		$params = array (':module_id' => $moduleId);

		// Execute the query and return the results
		return DatabaseHandler::GetRow($sql, $params);
	}

		// Retrieves all Module Keywords
	public static function GetModuleKeywords($moduleId)
	{
		// Build SQL query
		$sql = 'CALL get_module_keywords(:module_id)';

		// Build the parameters array
		$params = array (':module_id' => $moduleId);

		// Execute the query and return the results
		return DatabaseHandler::GetAll($sql, $params);
	}

		// Retrieves random modules
	public static function GetRandomModules()
	{
		// Build SQL query
		$sql = 'CALL get_random_modules()';

		// Execute the query and return the results
		return DatabaseHandler::GetAll($sql);
	}
	
	public static function GetRandom()
	{
		// Build SQL query
		$sql = 'CALL get_random_module()';

		// Execute the query and return the results
		return DatabaseHandler::GetAll($sql);
	}

		// Retrieves Module Leader
	public static function GetModuleLeader($moduleId)
	{
		// Build SQL query
		$sql = 'CALL get_module_leader(:module_id)';

		// Build the parameters array
		$params = array (':module_id' => $moduleId);

		// Execute the query and return the results
		return DatabaseHandler::GetOne($sql, $params);
	}

	  	// Retrieves all Module Leader modules
	public static function GetModuleLeaderModules($moduleleader)
	{
		// Build SQL query
		$sql = 'CALL get_module_leader_modules(:moduleleader)';

		// Build the parameters array
		$params = array (':moduleleader' => $moduleleader);

		// Execute the query and return the results
		return DatabaseHandler::GetAll($sql, $params);
	}

	// Retrieves all categories
	public static function GetCategories()
	{
		// Build SQL query
		$sql = 'CALL get_category_list()';

		// Execute the query and return the results
		return DatabaseHandler::GetAll($sql);
	}

	// Retrieves all Module Leaders
	public static function GetModuleLeaders()
	{
		// Build SQL query
		$sql = 'CALL get_module_leaders_list()';

		// Execute the query and return the results
		return DatabaseHandler::GetAll($sql);
	}

	/* Calculates how many pages of modules could be filled by the
		number of modules returned by the $countSql query */
	private static function HowManyPages($countSql, $countSqlParams)
	{
		// Create a hash for the sql query
		$queryHashCode = md5($countSql . var_export($countSqlParams, true));

		// Verify if we have the query results in cache
		if (isset ($_SESSION['last_count_hash']) &&
			isset ($_SESSION['how_many_pages']) &&
			$_SESSION['last_count_hash'] === $queryHashCode)
		{
			// Retrieve the the cached value
			$how_many_pages = $_SESSION['how_many_pages'];
		}
		else
		{
			// Execute the query
			$items_count = DatabaseHandler::GetOne($countSql, $countSqlParams);

			// Calculate the number of pages
			$how_many_pages = ceil($items_count / MODULES_PER_PAGE);

			// Save the query and its count result in the session
			$_SESSION['last_count_hash'] = $queryHashCode;
			$_SESSION['how_many_pages'] = $how_many_pages;
		}

		// Return the number of pages
		return $how_many_pages;
	}


	// Retrieves paged list of modules in collection page
	public static function GetModulesInCollection($pageNo, &$rHowManyPages)
	{
		// Query that returns the number of modules for the master page
		$sql = 'CALL count_modules_in_collection()';

		// Calculate the number of pages required to display the modules
		$rHowManyPages = Business::HowManyPages($sql, null);

		// Calculate the start item
		$start_item = ($pageNo - 1) * MODULES_PER_PAGE;

		// Retrieve the list of modules
		$sql = 'CALL get_modules_on_collection(:modules_per_page, :start_item)';

		// Build the parameters array
		$params = array (':modules_per_page' => MODULES_PER_PAGE, ':start_item' => $start_item);

		// Execute the query and return the results
		return DatabaseHandler::GetAll($sql, $params);
	}

    	// Retrieves all modules within a category
	public static function GetModulesByCategory($moduleCategory, $pageNo, &$rHowManyPages)
	{
		// Query that returns the number of modules
		$sql = 'CALL count_modules_in_collection_by_category(:module_category)';
		$params = array(':module_category' => $moduleCategory);

		// Calculate the number of pages required to display the modules
		$rHowManyPages = Business::HowManyPages($sql, $params);

		// Calculate the start item
		$start_item = ($pageNo - 1) * MODULES_PER_PAGE;

		// Build SQL query
		$sql = 'CALL get_modules_by_category(:module_category, :modules_per_page, :start_item)';

		// Build the parameters array

		$params = array (':module_category' => $moduleCategory, ':modules_per_page' => MODULES_PER_PAGE, ':start_item' => $start_item);

		// Execute the query and return the results
		return DatabaseHandler::GetAll($sql, $params);
	}

    	// Retrieves all modules with a keyword
	public static function GetModulesByKeyword($keyword, $pageNo, &$rHowManyPages)
	{
		// Query that returns the number of modules
		$sql = 'CALL count_modules_in_collection_by_keyword(:keyword)';
		$params = array(':keyword' => $keyword);

		// Calculate the number of pages required to display the modules
		$rHowManyPages = Business::HowManyPages($sql, $params);

		// Calculate the start item
		$start_item = ($pageNo - 1) * MODULES_PER_PAGE;

		// Build SQL query
		$sql = 'CALL get_modules_by_keyword(:keyword, :modules_per_page, :start_item)';

		// Build the parameters array

		$params = array (':keyword' => $keyword, ':modules_per_page' => MODULES_PER_PAGE, ':start_item' => $start_item);

		// Execute the query and return the results
		return DatabaseHandler::GetAll($sql, $params);
	}	
	
	// Search the collection
	public static function Search($searchString, $pageNo, &$rHowManyPages)
	{
		// Count the number of search results
		$sql = 'CALL count_search_result(:search_string)';
		$params = array(':search_string' => $searchString);

		// Calculate the number of pages required to display the modules
		$rHowManyPages = Business::HowManyPages($sql, $params);

		// Calculate the start item
		$start_item = ($pageNo - 1) * MODULES_PER_PAGE;

		// Retrieve the list of matching modules
		$sql = 'CALL search(:search_string, :modules_per_page, :start_item)';

		// Build the parameters array
		$params = array (':search_string' => $searchString, ':modules_per_page' => MODULES_PER_PAGE,
							':start_item' => $start_item);

		// Execute the query
		$search_result = DatabaseHandler::GetAll($sql, $params);

		// Return the results
		return $search_result;
	}
	// Retrieves all categories of Search Results
	public static function GetSearchResultCategories($searchString)
	{
		// Retrieve the list of matching modules
		$sql = 'CALL get_category_list_search(:search_string)';

		// Build the parameters array
		$params = array (':search_string' => $searchString);

		// Execute the query
		return DatabaseHandler::GetAll($sql, $params);
	}

	// Retrieves all categories of keyword Results
	public static function GetKeywordCategories($keyword)
	{
		// Retrieve the list of matching modules
		$sql = 'CALL get_keyword_category_list(:keyword)';

		// Build the parameters array
		$params = array (':keyword' => $keyword);

		// Execute the query
		return DatabaseHandler::GetAll($sql, $params);
	}	
	
	// Search the collection
	public static function GetModulesByCategorySearch($searchString, $moduleCategory, $pageNo, &$rHowManyPages)
	{
		// Count the number of search results
		$sql = 'CALL count_search_category_result(:search_string, :module_category)';

		$params = array(':search_string' => $searchString, ':module_category' => $moduleCategory);

		// Calculate the number of pages required to display the modules
		$rHowManyPages = Business::HowManyPages($sql, $params);

		// Calculate the start item
		$start_item = ($pageNo - 1) * MODULES_PER_PAGE;

		// Retrieve the list of matching modules
		$sql = 'CALL search_category(:search_string, :module_category, :modules_per_page, :start_item)';

		// Build the parameters array
		$params = array (':search_string' => $searchString, ':module_category' => $moduleCategory, ':modules_per_page' => MODULES_PER_PAGE, ':start_item' => $start_item);

		// Execute the query
		$search_result = DatabaseHandler::GetAll($sql, $params);

		// Return the results
		return $search_result;
	}

	// Search the collection
	public static function GetModulesByCategoryKeyword($keyword, $moduleCategory, $pageNo, &$rHowManyPages)
	{
		// Count the number of search results
		$sql = 'CALL count_keyword_category_result(:keyword, :module_category)';

		$params = array(':module_category' => $moduleCategory, ':keyword' => $keyword);

		// Calculate the number of pages required to display the modules
		$rHowManyPages = Business::HowManyPages($sql, $params);

		// Calculate the start item
		$start_item = ($pageNo - 1) * MODULES_PER_PAGE;

		// Retrieve the list of matching modules
		$sql = 'CALL get_modules_by_keyword_category(:keyword, :module_category, :modules_per_page, :start_item)';

		// Build the parameters array
		$params = array (':module_category' => $moduleCategory, ':keyword' => $keyword, ':modules_per_page' => MODULES_PER_PAGE, ':start_item' => $start_item);

		// Return the results
		return DatabaseHandler::GetAll($sql, $params);
	}	
	
  // Add a module
  public static function AddModule($moduleTitle, $moduleLeader, $moduleDescription, $image, $moduleCategory)
  {
    // Build the SQL query
    $sql = 'CALL add_module(:module_title, :module_leader, :module_description, :image, :module_category)';

    // Build the parameters array
    $params = array (':module_title' => $moduleTitle,
                     ':module_leader' => $moduleLeader,
					 ':module_description' => $moduleDescription,
					 ':image'=> $image,
					 ':module_category'=>$moduleCategory);

    // Execute the query
    DatabaseHandler::Execute($sql, $params);
  }

    // Add a keyword
  public static function AddKeyword($keywordTerm)
  {
    // Build the SQL query
    $sql = 'CALL add_keyword(:keyword_term)';

    // Build the parameters array
    $params = array (':keyword_term' => $keywordTerm);

    // Execute the query
    DatabaseHandler::Execute($sql, $params);
  }
  
      // Add a keyword to a module
  public static function AddKeywordToModule($moduleId, $keywordId)
  {
    // Build the SQL query
    $sql = 'CALL add_keyword_to_module(:module_id, :keyword_id)';

    // Build the parameters array
    $params = array (':module_id' => $moduleId, ':keyword_id' => $keywordId);

    // Execute the query
    DatabaseHandler::Execute($sql, $params);
  }
  
  // Updates module details
  public static function UpdateModule($moduleId, $moduleTitle, $moduleLeader, $moduleDescription, $image, $moduleCategory)
  {
    // Build the SQL query
    $sql = 'CALL update_module(:module_id, :module_title, :module_leader, :module_description, :image, :module_category)';

    // Build the parameters array
    $params = array (':module_id' => $moduleId,
                     ':module_title' => $moduleTitle,
                     ':module_leader' => $moduleLeader,
					 ':module_description' => $moduleDescription,
					 ':image'=> $image,
					 ':module_category'=>$moduleCategory);

    // Execute the query
    DatabaseHandler::Execute($sql, $params);
  }
  public static function DeleteModule($moduleId)
  {
    // Build the SQL query
    $sql = 'CALL delete_module(:module_id)';

    // Build the parameters array
    $params = array (':module_id' => $moduleId);

    // Execute the query
    DatabaseHandler::Execute($sql, $params);
  }
}
?>
