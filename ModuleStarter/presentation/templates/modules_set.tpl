{* modules_set.tpl *}
{load_presentation_object filename="modules_set" assign="obj"}

{if $obj->mModules}
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
		{* Loop through the set of modules *}
		{section name=i loop=$obj->mModules} 		
			<div class="module">
				<div class="image">     
					<a href="?op=Details&module_id={$obj->mModules[i].module_id}">
						<img src="./images/{$obj->mModules[i].module_image}" alt="{$obj->mModules[i].module_title}" /> 
					</a>
					<div class="moduledetails">
						<span class="moduletitle">{$obj->mModules[i].module_title}</span>
						<span class="leader">{$obj->mModules[i].module_leader}</span>
					</div>
				</div>				
			</div>
		{/section}
{/if}
		
{if count($obj->mModuleListPages) > 0}
   <div id="paginationDiv">
      {if $obj->mLinkToPreviousPage}
         <a href="{$obj->mLinkToPreviousPage}">
            Previous page</a>
      {/if}
	  
	  {section name=m loop=$obj->mModuleListPages}
         {if $obj->mPage eq $smarty.section.m.index_next}
            <strong>{$smarty.section.m.index_next}</strong>
         {else}
             <a href="{$obj->mModuleListPages[m]}">
                {$smarty.section.m.index_next}</a>
         {/if}
      {/section}
	  
		{if $obj->mLinkToNextPage}
          <a href="{$obj->mLinkToNextPage}">Next page</a>
      {/if}
	</div>
	
	{/if}