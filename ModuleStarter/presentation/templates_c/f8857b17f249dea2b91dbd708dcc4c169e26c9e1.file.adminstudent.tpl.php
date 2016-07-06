<?php /* Smarty version Smarty-3.1.14, created on 2014-10-28 14:53:46
         compiled from "C:\xampp\htdocs\ModuleStarter\presentation\templates\adminstudent.tpl" */ ?>
<?php /*%%SmartyHeaderCode:19964544be920a95087-66907449%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'f8857b17f249dea2b91dbd708dcc4c169e26c9e1' => 
    array (
      0 => 'C:\\xampp\\htdocs\\ModuleStarter\\presentation\\templates\\adminstudent.tpl',
      1 => 1414490938,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '19964544be920a95087-66907449',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_544be920af6b20_20041587',
  'variables' => 
  array (
    'obj' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_544be920af6b20_20041587')) {function content_544be920af6b20_20041587($_smarty_tpl) {?><?php if (!is_callable('smarty_function_load_presentation_object')) include 'C:\\xampp\\htdocs\\ModuleStarter/presentation/smarty_plugins\\function.load_presentation_object.php';
?>
<?php echo smarty_function_load_presentation_object(array('filename'=>"adminstudent",'assign'=>"obj"),$_smarty_tpl);?>

<!DOCTYPE HTML>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="author" content="Lewis Sidebotham" />
  <meta name="keywords" content="Module, Collection" />
  <meta name="description" content="Module Collection" />
  <link rel="stylesheet" type="text/css" href="./Styles/styles2014.css"
	    title="Default" media="all" />
  <title><?php echo $_smarty_tpl->getConfigVariable('site_title');?>
</title>
</head>
<body>
  <div id="container">
	<?php echo $_smarty_tpl->getSubTemplate ("header.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>

	<p>
		<a id="Menu_HomeLink" href="Index.php">Home</a>
	</p>
	<?php if ($_smarty_tpl->tpl_vars['obj']->value->mLoggedIn!=true){?>
		<div id="loginDiv">
			<?php echo $_smarty_tpl->getSubTemplate ("login.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>

		</div>
	<?php }else{ ?>
		<div id="logout">
			<a href="adminstudent.php?Page=Logout">Logout</a>
		</div>
	
		<div id='leftItemTemplate'>
			<?php if ($_smarty_tpl->tpl_vars['obj']->value->mUpdateButtonDisplay){?>
				<h3>Update Module</h3>
			<?php }else{ ?>
				<h3>Add New Module</h3>					
			<?php }?>		
			<form method="post" action="adminstudent.php">
			<?php if ($_smarty_tpl->tpl_vars['obj']->value->mErrorMessage){?><p class="error"><?php echo $_smarty_tpl->tpl_vars['obj']->value->mErrorMessage;?>
</p><?php }?>
			<div>
				<p>
					<label for="new_module_title">Title:</label><br />
					<input type="text" name="new_module_title" value="<?php echo $_smarty_tpl->tpl_vars['obj']->value->mModuleTitle;?>
" size="40" />
				</p>
				<p>
					<label for="new_leader">Leader:</label><br />            
					<input type="text" name="new_leader" value="<?php echo $_smarty_tpl->tpl_vars['obj']->value->mModuleLeader;?>
" size="40" />
				</p>
				<p>
					<label for="new_image">Image:</label><br />			
					<input type="text" name="new_image" value="<?php echo $_smarty_tpl->tpl_vars['obj']->value->mImage;?>
" size="40" />
				</p>
				<p>
					<label for="new_category">Category:</label><br />			
					<input type="text" name="new_category" value="<?php echo $_smarty_tpl->tpl_vars['obj']->value->mCategory;?>
" size="10" />
				</p>
					<label for="new_description">Description:<label><br />
					<label type="text" name="new_description" value="<?php echo $_smarty_tpl->tpl_vars['obj']->value->mModuleDescription;?>
" size="140">
				<p>
					<?php if ($_smarty_tpl->tpl_vars['obj']->value->mAddButtonDisplay){?>
						<input type="submit" name="submit_add" value="Add" /> 
					<?php }?>
					<?php if ($_smarty_tpl->tpl_vars['obj']->value->mUpdateButtonDisplay){?>					
						<input type="submit" name="submit_edit" value="Update" />					
					<?php }?>
				</p>
			</div>
			</form>
		</div>
		
	<?php }?>
  </div>
</body>
</html><?php }} ?>