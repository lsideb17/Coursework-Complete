{* smarty *}
{config_load file="site.conf"}
{load_presentation_object filename="master" assign="obj"}
<!DOCTYPE HTML>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="author" content="Lewis Sidebotham" />
	<meta name="keywords" content="Module, Catalogue" />
	<meta name="description" content="Module Catalogue" />
	<link rel="stylesheet" type="text/css" href="./Styles/styles2014.css"
	    title="Default" media="all" />
	<script src="./scripts/modules2014.js"></script>		
	<title>{#site_title#}</title>
</head>
<body>
	<div id="container">
		{include file="header.tpl"}	{include file="menu.tpl"}
	
		<div id="sidebar">
			{include file=$obj->mSideBar}        
		</div>
	
		<div id="content">
			{include file=$obj->mContents}
		</div>
	
		{include file="footer.tpl"}
	</div>
</body>
</html>
