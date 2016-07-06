<?php /* Smarty version Smarty-3.1.14, created on 2014-11-08 23:49:04
         compiled from "C:\xampp\htdocs\ModuleStarter\presentation\templates\adminmodule.tpl" */ ?>
<?php /*%%SmartyHeaderCode:9646544ba7db3d3792-19939910%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '83b7e15abacc8100e083daad516dd21484924488' => 
    array (
      0 => 'C:\\xampp\\htdocs\\ModuleStarter\\presentation\\templates\\adminmodule.tpl',
      1 => 1415486869,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '9646544ba7db3d3792-19939910',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_544ba7db5cb681_71558849',
  'variables' => 
  array (
    'obj' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_544ba7db5cb681_71558849')) {function content_544ba7db5cb681_71558849($_smarty_tpl) {?><?php if (!is_callable('smarty_function_load_presentation_object')) include 'C:\\xampp\\htdocs\\ModuleStarter/presentation/smarty_plugins\\function.load_presentation_object.php';
?>
<?php echo smarty_function_load_presentation_object(array('filename'=>"adminmodule",'assign'=>"obj"),$_smarty_tpl);?>

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
			<a href="moduleadmin.php?Page=Logout">Logout</a>
		</div>
	
<div id='leftItemTemplate'>
	<?php if ($_smarty_tpl->tpl_vars['obj']->value->mUpdateButtonDisplay){?>
		<h3>Update Module</h3>
		<?php }else{ ?>
		<h3>Add New Module</h3>					
		<?php }?>		
		<form method="post" action="moduleadmin.php">
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
			<input type="text" name="new_module_leader" value="<?php echo $_smarty_tpl->tpl_vars['obj']->value->mModuleLeader;?>
" size="40" />
		</p>
		<p>
			<label for="new_image">Image:</label><br />			
			<input type="file" name="new_image" value="<?php echo $_smarty_tpl->tpl_vars['obj']->value->mImage;?>
" size="40" />
		</p>
		<p>
			<label for="new_description">Description:<label><br />
			<input type="text" name="new_module_description" value="<?php echo $_smarty_tpl->tpl_vars['obj']->value->mModuleDescription;?>
" size="40" />
		</p>
		<p>
			<label for="new_category">Category:</label><br />			
			<input type="text" name="new_module_category" value="<?php echo $_smarty_tpl->tpl_vars['obj']->value->mModuleCategory;?>
" size="10" />
		</p>
		<p>
			<label for="new_keywords">Keywords for Module:</label><br />			
			<input type="text" name="new_keyword" value="<?php echo $_smarty_tpl->tpl_vars['obj']->value->mKeyword;?>
" size="20" />
			<input type="text" name="new_keyword" value="<?php echo $_smarty_tpl->tpl_vars['obj']->value->mKeyword;?>
" size="20" />
			<input type="text" name="new_keyword" value="<?php echo $_smarty_tpl->tpl_vars['obj']->value->mKeyword;?>
" size="20" />
		</p>
		<p>
			<input type="hidden" name="module_id" value="<?php echo $_smarty_tpl->tpl_vars['obj']->value->mModuleID;?>
" />
		</p>
		<p>
			<?php if ($_smarty_tpl->tpl_vars['obj']->value->mAddButtonDisplay){?>
				<input type="submit" name="submit_add" value="Add Module" /> 
			<?php }?>
			
			<?php if ($_smarty_tpl->tpl_vars['obj']->value->mUpdateButtonDisplay){?>					
				<input type="submit" name="submit_edit" value="Update Module" />					
			<?php }?>
		</p>
	</div>
	</form>
</div>
<?php if ($_smarty_tpl->tpl_vars['obj']->value->mModuleLeaders){?>
			<div id='rightItemTemplate'>
				<h3>Find Module to Update</h3>
				<form method="post" action="moduleadmin.php">
				<div>
					<p>
						<select name="leaders">
							<option>Select Leader</option>
							
							<?php if (isset($_smarty_tpl->tpl_vars['smarty']->value['section']['i'])) unset($_smarty_tpl->tpl_vars['smarty']->value['section']['i']);
$_smarty_tpl->tpl_vars['smarty']->value['section']['i']['name'] = 'i';
$_smarty_tpl->tpl_vars['smarty']->value['section']['i']['loop'] = is_array($_loop=$_smarty_tpl->tpl_vars['obj']->value->mModuleLeaders) ? count($_loop) : max(0, (int)$_loop); unset($_loop);
$_smarty_tpl->tpl_vars['smarty']->value['section']['i']['show'] = true;
$_smarty_tpl->tpl_vars['smarty']->value['section']['i']['max'] = $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['loop'];
$_smarty_tpl->tpl_vars['smarty']->value['section']['i']['step'] = 1;
$_smarty_tpl->tpl_vars['smarty']->value['section']['i']['start'] = $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['step'] > 0 ? 0 : $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['loop']-1;
if ($_smarty_tpl->tpl_vars['smarty']->value['section']['i']['show']) {
    $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['total'] = $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['loop'];
    if ($_smarty_tpl->tpl_vars['smarty']->value['section']['i']['total'] == 0)
        $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['show'] = false;
} else
    $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['total'] = 0;
if ($_smarty_tpl->tpl_vars['smarty']->value['section']['i']['show']):

            for ($_smarty_tpl->tpl_vars['smarty']->value['section']['i']['index'] = $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['start'], $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['iteration'] = 1;
                 $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['iteration'] <= $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['total'];
                 $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['index'] += $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['step'], $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['iteration']++):
$_smarty_tpl->tpl_vars['smarty']->value['section']['i']['rownum'] = $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['iteration'];
$_smarty_tpl->tpl_vars['smarty']->value['section']['i']['index_prev'] = $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['index'] - $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['step'];
$_smarty_tpl->tpl_vars['smarty']->value['section']['i']['index_next'] = $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['index'] + $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['step'];
$_smarty_tpl->tpl_vars['smarty']->value['section']['i']['first']      = ($_smarty_tpl->tpl_vars['smarty']->value['section']['i']['iteration'] == 1);
$_smarty_tpl->tpl_vars['smarty']->value['section']['i']['last']       = ($_smarty_tpl->tpl_vars['smarty']->value['section']['i']['iteration'] == $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['total']);
?>
								
								<option value="<?php echo $_smarty_tpl->tpl_vars['obj']->value->mModuleLeaders[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['module_leader'];?>
"><?php echo $_smarty_tpl->tpl_vars['obj']->value->mModuleLeaders[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['module_leader'];?>
</option>
							<?php endfor; endif; ?>        
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
							<?php if (isset($_smarty_tpl->tpl_vars['smarty']->value['section']['i'])) unset($_smarty_tpl->tpl_vars['smarty']->value['section']['i']);
$_smarty_tpl->tpl_vars['smarty']->value['section']['i']['name'] = 'i';
$_smarty_tpl->tpl_vars['smarty']->value['section']['i']['loop'] = is_array($_loop=$_smarty_tpl->tpl_vars['obj']->value->mModuleLeaders) ? count($_loop) : max(0, (int)$_loop); unset($_loop);
$_smarty_tpl->tpl_vars['smarty']->value['section']['i']['show'] = true;
$_smarty_tpl->tpl_vars['smarty']->value['section']['i']['max'] = $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['loop'];
$_smarty_tpl->tpl_vars['smarty']->value['section']['i']['step'] = 1;
$_smarty_tpl->tpl_vars['smarty']->value['section']['i']['start'] = $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['step'] > 0 ? 0 : $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['loop']-1;
if ($_smarty_tpl->tpl_vars['smarty']->value['section']['i']['show']) {
    $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['total'] = $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['loop'];
    if ($_smarty_tpl->tpl_vars['smarty']->value['section']['i']['total'] == 0)
        $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['show'] = false;
} else
    $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['total'] = 0;
if ($_smarty_tpl->tpl_vars['smarty']->value['section']['i']['show']):

            for ($_smarty_tpl->tpl_vars['smarty']->value['section']['i']['index'] = $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['start'], $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['iteration'] = 1;
                 $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['iteration'] <= $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['total'];
                 $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['index'] += $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['step'], $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['iteration']++):
$_smarty_tpl->tpl_vars['smarty']->value['section']['i']['rownum'] = $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['iteration'];
$_smarty_tpl->tpl_vars['smarty']->value['section']['i']['index_prev'] = $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['index'] - $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['step'];
$_smarty_tpl->tpl_vars['smarty']->value['section']['i']['index_next'] = $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['index'] + $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['step'];
$_smarty_tpl->tpl_vars['smarty']->value['section']['i']['first']      = ($_smarty_tpl->tpl_vars['smarty']->value['section']['i']['iteration'] == 1);
$_smarty_tpl->tpl_vars['smarty']->value['section']['i']['last']       = ($_smarty_tpl->tpl_vars['smarty']->value['section']['i']['iteration'] == $_smarty_tpl->tpl_vars['smarty']->value['section']['i']['total']);
?>
								<option value="<?php echo $_smarty_tpl->tpl_vars['obj']->value->mModules['module_leader'];?>
"><?php echo $_smarty_tpl->tpl_vars['obj']->value->mModules['module_title'];?>
</option>
							<?php endfor; endif; ?>        
						</select>
				</p>
				<p>
					<input type="submit" name="submit_select_module" value="Select Module" />        
				</p>
			</div> 
		<?php }?>	
<?php }?>
 </div>
</body>
</html><?php }} ?>