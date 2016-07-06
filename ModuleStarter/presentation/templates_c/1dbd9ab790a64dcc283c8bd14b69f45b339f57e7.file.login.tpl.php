<?php /* Smarty version Smarty-3.1.14, created on 2014-10-28 20:31:42
         compiled from "C:\xampp\htdocs\ModuleStarter\presentation\templates\login.tpl" */ ?>
<?php /*%%SmartyHeaderCode:2516654481cf6415f73-43971179%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '1dbd9ab790a64dcc283c8bd14b69f45b339f57e7' => 
    array (
      0 => 'C:\\xampp\\htdocs\\ModuleStarter\\presentation\\templates\\login.tpl',
      1 => 1414506784,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '2516654481cf6415f73-43971179',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_54481cf64d94a7_43560451',
  'variables' => 
  array (
    'obj' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_54481cf64d94a7_43560451')) {function content_54481cf64d94a7_43560451($_smarty_tpl) {?><?php if (!is_callable('smarty_function_load_presentation_object')) include 'C:\\xampp\\htdocs\\ModuleStarter/presentation/smarty_plugins\\function.load_presentation_object.php';
?>
<?php  $_config = new Smarty_Internal_Config("site.conf", $_smarty_tpl->smarty, $_smarty_tpl);$_config->loadConfigVars(null, 'local'); ?>
<?php echo smarty_function_load_presentation_object(array('filename'=>"login",'assign'=>"obj"),$_smarty_tpl);?>

<div>
	<h2 style="color:red">Login</h2>
	<form method="post" action="./moduleadmin.php" id="loginForm">
	<div>
		<?php if ($_smarty_tpl->tpl_vars['obj']->value->mLoginMessage!=''){?>
			<p class="error"><?php echo $_smarty_tpl->tpl_vars['obj']->value->mLoginMessage;?>
</p>
		<?php }?>    
		<p>
			<label for="username">Username:</label>
			<input type="text" name="username" size="35" />
			<label for="password">Password:</label>
			<input type="password" name="password" size="35" />
			<input type="submit" name="submit" value="Login" />
		</p>        
	</div>
	</form>
</div>
<?php }} ?>