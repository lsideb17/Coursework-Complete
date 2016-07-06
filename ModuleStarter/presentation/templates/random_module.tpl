{* random_module.tpl *}
{load_presentation_object filename="random_module" assign="obj"}

{if $obj->mRandomModule}
<div id="styleChoice">
	<li>
		<a href="?op=Random"> <img src="./images/random.png" WIDTH=20 HEIGHT=20 /></a> {*Add ?op= *}
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
		{section name=i loop=$obj->mRandomModule} 		
			<div class="module">
				<div class="image">     
					<a href="?op=Details&module_id={$obj->mRandomModule[i].module_id}">
						<img src="./images/{$obj->mRandomModule[i].module_image}" alt="{$obj->mRandomModule[i].module_title}" /> 
					</a>
					<div class="moduledetails">
						<span class="moduletitle">{$obj->mRandomModule[i].module_title}</span>
						<span class="leader">{$obj->mRandomModule[i].module_leader}</span>
					</div>
				</div>				
			</div>
		</div>
		{/section}
	</div>
{/if}