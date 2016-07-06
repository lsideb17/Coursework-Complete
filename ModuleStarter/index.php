<?php
	session_name('modules');
	session_start();

	// Include utility files
	require_once 'include/config.php';

	// Load the application page template
	require_once PRESENTATION_DIR . 'application.php';

	// Create Smarty Application
	$application = new Application();
		
	// Determine requested functionality 
	if (isset($_GET["op"]))
		$_SESSION['CurrentPage'] = $_GET["op"];
	else
		$_SESSION['CurrentPage'] = 'Home';
	
	// Display the page
	$application->display('master.tpl');
?>