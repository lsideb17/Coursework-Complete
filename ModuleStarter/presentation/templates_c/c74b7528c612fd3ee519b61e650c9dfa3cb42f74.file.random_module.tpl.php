<?php /* Smarty version Smarty-3.1.14, created on 2014-11-09 19:20:47
         compiled from "C:\xampp\htdocs\ModuleStarter\presentation\templates\random_module.tpl" */ ?>
<?php /*%%SmartyHeaderCode:284815456855baad8f0-92781862%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'c74b7528c612fd3ee519b61e650c9dfa3cb42f74' => 
    array (
      0 => 'C:\\xampp\\htdocs\\ModuleStarter\\presentation\\templates\\random_module.tpl',
      1 => 1415557177,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '284815456855baad8f0-92781862',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_5456855baff980_80273496',
  'variables' => 
  array (
    'obj' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5456855baff980_80273496')) {function content_5456855baff980_80273496($_smarty_tpl) {?><?php if (!is_callable('smarty_function_load_presentation_object')) include 'C:\\xampp\\htdocs\\ModuleStarter/presentation/smarty_plugins\\function.load_presentation_object.php';
?>
<?php echo smarty_function_load_presentation_object(array('filename'=>"random_module",'assign'=>"obj"),$_smarty_tpl);?>


<?php if ($_smarty_tpl->tpl_vars['obj']->value->mRandomModule){?>
<div id="styleChoice">
	<li>
		<a href="?op=Random"> <img src="./images/random.png" WIDTH=20 HEIGHT=20 /></a> 
	</li>
		<div id="gridView" class="hidden" onclick="toggleView()">
			<img src="./images/grid.png" alt="Grid View" />
		</div>
		<div id="listView" onclick="toggleView()">
			<img src="./images/list.png" alt="List View" />
		</div>
	</div>	
	<div id="main" class="grid">
		<div class="modules">
		
		<?php if (isset($_smarty_tpl->tpl_vars['smarty']->value['section']['i'])) unset($_smarty_tpl->tpl_vars['smarty']->value['section']['i']);
$_smarty_tpl->tpl_vars['smarty']->value['section']['i']['name'] = 'i';
$_smarty_tpl->tpl_vars['smarty']->value['section']['i']['loop'] = is_array($_loop=$_smarty_tpl->tpl_vars['obj']->value->mRandomModule) ? count($_loop) : max(0, (int)$_loop); unset($_loop);
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
			<div class="module">
				<div class="image">     
					<a href="?op=Details&module_id=<?php echo $_smarty_tpl->tpl_vars['obj']->value->mRandomModule[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['module_id'];?>
">
						<img src="./images/<?php echo $_smarty_tpl->tpl_vars['obj']->value->mRandomModule[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['module_image'];?>
" alt="<?php echo $_smarty_tpl->tpl_vars['obj']->value->mRandomModule[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['module_title'];?>
" /> 
					</a>
					<div class="moduledetails">
						<span class="moduletitle"><?php echo $_smarty_tpl->tpl_vars['obj']->value->mRandomModule[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['module_title'];?>
</span>
						<span class="leader"><?php echo $_smarty_tpl->tpl_vars['obj']->value->mRandomModule[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['module_leader'];?>
</span>
					</div>
				</div>				
			</div>
		</div>
		<?php endfor; endif; ?>
	</div>
<?php }?><?php }} ?>