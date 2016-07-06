{* adminmodule.tpl *}
{load_presentation_object filename="adminmodule" assign="obj"}
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
			<a href="moduleadmin.php?Page=Logout">Logout</a>
		</div>
	
<div id='leftItemTemplate'>
	{if $obj->mUpdateButtonDisplay}
		<h3>Update Module</h3>
		{else}
		<h3>Add New Module</h3>					
		{/if}		
		<form method="post" action="moduleadmin.php">
		{if $obj->mErrorMessage}<p class="error">{$obj->mErrorMessage}</p>{/if}
		<div>
		<p>
			<label for="new_module_title">Title:</label><br />
			<input type="text" name="new_module_title" value="{$obj->mModuleTitle}" size="40" />
		</p>
		<p>
			<label for="new_leader">Leader:</label><br />            
			<input type="text" name="new_module_leader" value="{$obj->mModuleLeader}" size="40" />
		</p>
		<p>
			<label for="new_image">Image:</label><br />			
			<input type="file" name="new_image" value="{$obj->mImage}" size="40" />
		</p>
		<p>
			<label for="new_description">Description:<label><br />
			<input type="text" name="new_module_description" value="{$obj->mModuleDescription}" size="40" />
		</p>
		<p>
			<label for="new_category">Category:</label><br />			
			<input type="text" name="new_module_category" value="{$obj->mModuleCategory}" size="10" />
		</p>
		<p>
			<label for="new_keywords">Keywords for Module:</label><br />			
			<input type="text" name="new_keyword" value="{$obj->mKeyword}" size="20" />
			<input type="text" name="new_keyword" value="{$obj->mKeyword}" size="20" />
			<input type="text" name="new_keyword" value="{$obj->mKeyword}" size="20" />
		</p>
		<p>
			<input type="hidden" name="module_id" value="{$obj->mModuleID}" />
		</p>
		<p>
			{if $obj->mAddButtonDisplay}
				<input type="submit" name="submit_add" value="Add Module" /> 
			{/if}
			
			{if $obj->mUpdateButtonDisplay}					
				<input type="submit" name="submit_edit" value="Update Module" />					
			{/if}
		</p>
	</div>
	</form>
</div>
{if $obj->mModuleLeaders}
			<div id='rightItemTemplate'>
				<h3>Find Module to Update</h3>
				<form method="post" action="moduleadmin.php">
				<div>
					<p>
						<select name="leaders">
							<option>Select Leader</option>
							{* Loop through the list of leaders *}
							{section name=i loop=$obj->mModuleLeaders}
								{* Generate a new leader in the list *}
								<option value="{$obj->mModuleLeaders[i].module_leader}">{$obj->mModuleLeaders[i].module_leader}</option>
							{/section}        
						</select>
            		</p>
					<p>
						<input type="submit" name="submit_select_leader" value="Select Leader" />        
					</p>
				</div>
				</form>
				<div>
				<p>
					<select name="module">
						<option>Select Module</option>
							{section name=i loop=$obj->mModuleLeaders}
								<option value="{$obj->mModules.module_leader}">{$obj->mModules.module_title}</option>
							{/section}        
						</select>
				</p>
				<p>
					<input type="submit" name="submit_select_module" value="Select Module" />        
				</p>
			</div> 
		{/if}	
{/if}
 </div>
</body>
</html>