{* logo_menu.tpl *}
<div id="main-nav">
	{include file="searchbox.tpl"}
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
		<a id="Menu_ModuleAdminLink" href="moduleadmin.php">Module Admin</a> {*Add ?op= *}
	</li>     
	<li>
		<a id="Menu_StudentAdminLink" href="studentadmin.php">Student Admin</a> {*Add ?op= *}
	</li>
	
	</ul>
</div>

