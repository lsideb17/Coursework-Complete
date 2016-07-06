<?php
	// Class that deals with authenticating administrators
	class Login
	{
		// Public variables available in smarty templates
		public $mUsername;
		public $mLoginMessage = '';

 		// Class constructor
		public function __construct()
		{
			// Verify if the correct username and password have been supplied
			if (isset ($_POST['submit']))
			{
				if ($_POST['username'] == MODULEADMIN_USERNAME && $_POST['password'] == MODULEADMIN_PASSWORD)
				{
					$_SESSION['adminmodule_logged'] = true;			
					header('Location: moduleadmin.php');
					exit();					
				}
				else if ($_POST['susername'] == STUDENTADMIN_USERNAME && $_POST['password'] == STUDENTADMIN_PASSWORD)
				{
					$_SESSION['adminstudent_logged'] = true;			
					header('Location: studentadmin.php');
					exit();					
				}				
				else
				{				
					$this->mLoginMessage = 'Login failed. Please try again:';
				}
				
			}			
		}
	}
?>