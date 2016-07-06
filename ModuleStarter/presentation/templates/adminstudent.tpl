{* adminstudent.tpl *}
{load_presentation_object filename="adminstudent" assign="obj"}
<!DOCTYPE HTML>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="author" content="Lewis Sidebotham" />
  <meta name="keywords" content="Module, Collection" />
  <meta name="description" content="Module Collection" />
  <link rel="stylesheet" type="text/css" href="./Styles/styles2014.css"
	    title="Default" media="all" />
  <title>{#site_title#}</title>
</head>
<body>
  <div id="container">
	{include file="header.tpl"}
	<p>
		<a id="Menu_HomeLink" href="Index.php">Home</a>
	</p>
	{if $obj->mLoggedIn neq TRUE}
		<div id="loginDiv">
			{include file="login.tpl"}
		</div>
	{else}
		<div id="logout">
			<a href="adminstudent.php?Page=Logout">Logout</a>
		</div>
	
		<div id='leftItemTemplate'>
			{if $obj->mUpdateButtonDisplay}
				<h3>Update Module</h3>
			{else}
				<h3>Add New Module</h3>					
			{/if}		
			<form method="post" action="adminstudent.php">
			{if $obj->mErrorMessage}<p class="error">{$obj->mErrorMessage}</p>{/if}
			<div>
				<p>
					<label for="new_module_title">Title:</label><br />
					<input type="text" name="new_module_title" value="{$obj->mModuleTitle}" size="40" />
				</p>
				<p>
					<label for="new_leader">Leader:</label><br />            
					<input type="text" name="new_leader" value="{$obj->mModuleLeader}" size="40" />
				</p>
				<p>
					<label for="new_image">Image:</label><br />			
					<input type="text" name="new_image" value="{$obj->mImage}" size="40" />
				</p>
				<p>
					<label for="new_category">Category:</label><br />			
					<input type="text" name="new_category" value="{$obj->mCategory}" size="10" />
				</p>
					<label for="new_description">Description:<label><br />
					<label type="text" name="new_description" value="{$obj->mModuleDescription}" size="140">
				<p>
					{if $obj->mAddButtonDisplay}
						<input type="submit" name="submit_add" value="Add" /> 
					{/if}
					{if $obj->mUpdateButtonDisplay}					
						<input type="submit" name="submit_edit" value="Update" />					
					{/if}
				</p>
			</div>
			</form>
		</div>
		
	{/if}
  </div>
</body>
</html>