<?php /* Smarty version Smarty-3.1.14, created on 2014-11-09 00:24:05
         compiled from "C:\xampp\htdocs\ModuleStarter\presentation\templates\searchbox.tpl" */ ?>
<?php /*%%SmartyHeaderCode:1619154465cfac4b021-45999469%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'e65cf4f85d70ed821f47bd474e4808653bcb4aef' => 
    array (
      0 => 'C:\\xampp\\htdocs\\ModuleStarter\\presentation\\templates\\searchbox.tpl',
      1 => 1415489041,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '1619154465cfac4b021-45999469',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_54465cfac4d749_63892461',
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_54465cfac4d749_63892461')) {function content_54465cfac4d749_63892461($_smarty_tpl) {?>
<div id="searchBox">
	<form method="post" action="?op=Search" id="searchForm">
	<div>
		<p>
			<input maxlength="100" id="searchText" name="searchText" size="25" />
			<input type="submit" value="Search" />
			
		</p>
	</div>
	</form>
</div>




<?php }} ?>