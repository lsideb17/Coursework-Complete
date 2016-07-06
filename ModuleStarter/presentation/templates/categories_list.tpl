{* categories_list.tpl *}
{load_presentation_object filename="categories_list" assign="obj"}
<div>
	<h2>Categories</h2>
	{if $obj->mModuleCategory}
		<ul>
		{* Loop through the list of Module Categories *}
		{section name=i loop=$obj->mModuleCategory}
		<li>
			{* Generate a new category in the list *}
			{if $obj->mSearchString}
				<a href="?op=Filter&category={$obj->mModuleCategory[i].module_category}&searchText={$obj->mSearchString}">
			{else}
				<a href="?op=Filter&category={$obj->mModuleCategory[i].module_category}"> 
			{/if}			
			{$obj->mModuleCategory[i].module_category}</a>&nbsp;
			({$obj->mModuleCategory[i].count})
		</li>
		{/section}
		</ul>
		{* End categories list *}
	{/if}
</div>



