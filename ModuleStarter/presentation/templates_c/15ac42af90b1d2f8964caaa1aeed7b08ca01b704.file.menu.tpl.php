<?php /* Smarty version Smarty-3.1.14, created on 2014-11-04 12:06:04
         compiled from "C:\xampp\htdocs\ModuleStarter\presentation\templates\menu.tpl" */ ?>
<?php /*%%SmartyHeaderCode:2851054465cfac2c8c5-25903635%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '15ac42af90b1d2f8964caaa1aeed7b08ca01b704' => 
    array (
      0 => 'C:\\xampp\\htdocs\\ModuleStarter\\presentation\\templates\\menu.tpl',
      1 => 1415005154,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '2851054465cfac2c8c5-25903635',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_54465cfac31571_74805209',
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_54465cfac31571_74805209')) {function content_54465cfac31571_74805209($_smarty_tpl) {?>
<div id="main-nav">
	<?php echo $_smarty_tpl->getSubTemplate ("searchbox.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null, array(), 0);?>

    <ul id="menu">
	<li>
		<a id="Menu_HomeLink" href="Index.php">Home</a>
	</li>
	<li>
		<a id="Menu_ModulesLink" href="?op=Modules">Modules</a>
	</li>
	<li>
		<a id="Menu_ModuleLeadersLink" href="?op=ModuleLeaders">Module Leaders</a> 
	</li> 
	<li>
		<a id="Menu_ModuleAdminLink" href="moduleadmin.php">Module Admin</a> 
	</li>     
	<li>
		<a id="Menu_StudentAdminLink" href="studentadmin.php">Student Admin</a> 
	</li>
	
	</ul>
</div>

<?php }} ?>