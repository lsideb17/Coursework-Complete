<?php /* Smarty version Smarty-3.1.14, created on 2014-11-09 20:10:55
         compiled from "C:\xampp\htdocs\ModuleStarter\presentation\templates\module_details.tpl" */ ?>
<?php /*%%SmartyHeaderCode:16697544fc552cc2cc9-73596879%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '4b311ee920a52c45185536df5c0c629e6815bb87' => 
    array (
      0 => 'C:\\xampp\\htdocs\\ModuleStarter\\presentation\\templates\\module_details.tpl',
      1 => 1415560254,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '16697544fc552cc2cc9-73596879',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.14',
  'unifunc' => 'content_544fc552d4f2c6_94462957',
  'variables' => 
  array (
    'obj' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_544fc552d4f2c6_94462957')) {function content_544fc552d4f2c6_94462957($_smarty_tpl) {?><?php if (!is_callable('smarty_function_load_presentation_object')) include 'C:\\xampp\\htdocs\\ModuleStarter/presentation/smarty_plugins\\function.load_presentation_object.php';
?>
<?php echo smarty_function_load_presentation_object(array('filename'=>"module_details",'assign'=>"obj"),$_smarty_tpl);?>


<?php if ($_smarty_tpl->tpl_vars['obj']->value->mModule){?>
	<li>
		<a href="?op=Random"> <img src="./images/random.png" WIDTH=20 HEIGHT=20 /></a> 
	</li>
<div>
    <div id="module">
		<h2><?php echo $_smarty_tpl->tpl_vars['obj']->value->mModule['module_title'];?>
 - <?php echo $_smarty_tpl->tpl_vars['obj']->value->mModule['module_leader'];?>
</h2>
		
		<div id='leftItemTemplate'>
			<p><img src='./images/<?php echo $_smarty_tpl->tpl_vars['obj']->value->mModule['module_image'];?>
' alt='<?php echo $_smarty_tpl->tpl_vars['obj']->value->mModule['module_title'];?>
 Module Image' /></p>
			
			
			<h2>Module Leader: </h2>
			<?php if ($_smarty_tpl->tpl_vars['obj']->value->mModule){?>
				<div id="module_leader">
						<ul>
							<?php echo $_smarty_tpl->tpl_vars['obj']->value->mModule['module_leader'];?>

						</ul>
				</div>
			<?php }?>
		</div>
		<p>
		<input type="submit" name="delete_module" value="Delete Module" />
		</p>
		</div>
		<div id='rightItemTemplate'>
		
		
		
		<h2>Keywords: </h2>
			<?php if ($_smarty_tpl->tpl_vars['obj']->value->mKeyword){?>
				<div id="keyword">
						
						<?php if (isset($_smarty_tpl->tpl_vars['smarty']->value['section']['i'])) unset($_smarty_tpl->tpl_vars['smarty']->value['section']['i']);
$_smarty_tpl->tpl_vars['smarty']->value['section']['i']['name'] = 'i';
$_smarty_tpl->tpl_vars['smarty']->value['section']['i']['loop'] = is_array($_loop=$_smarty_tpl->tpl_vars['obj']->value->mKeyword) ? count($_loop) : max(0, (int)$_loop); unset($_loop);
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
						<li>
							<?php echo $_smarty_tpl->tpl_vars['obj']->value->mKeyword[$_smarty_tpl->getVariable('smarty')->value['section']['i']['index']]['keyword_term'];?>

						</li>
						<?php endfor; endif; ?>
				</div>
			
			<?php }?>
			
			
			
			
		<h2>Description of Module: </h2>
			<?php if ($_smarty_tpl->tpl_vars['obj']->value->mModule){?>
				<div id="module_description">
						
							<?php echo $_smarty_tpl->tpl_vars['obj']->value->mModule['module_description'];?>

						
				</div>
			<?php }?>
		</div>
		
		
		
		
	</div>

</div>
<?php }?> 
     
 <?php }} ?>