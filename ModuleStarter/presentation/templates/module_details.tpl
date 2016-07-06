{* module_details.tpl *}
{load_presentation_object filename="module_details" assign="obj"}

{if $obj->mModule}
	<li>
		<a href="?op=Random"> <img src="./images/random.png" WIDTH=20 HEIGHT=20 /></a> 
	</li>
<div>
    <div id="module">
		<h2>{$obj->mModule.module_title} - {$obj->mModule.module_leader}</h2>
		
		<div id='leftItemTemplate'>
			<p><img src='./images/{$obj->mModule.module_image}' alt='{$obj->mModule.module_title} Module Image' /></p>
			
			
			<h2>Module Leader: </h2>
			{if $obj->mModule}
				<div id="module_leader">
						<ul>
							{$obj->mModule.module_leader}
						</ul>
				</div>
			{/if}
		</div>
		
		</div>
		<div id='rightItemTemplate'>
		
		
		
		<h2>Keywords: </h2>
			{if $obj->mKeyword}
				<div id="keyword">
						{* Loop through the list of tracks *}
						{section name=i loop=$obj->mKeyword}
						<li>
							{$obj->mKeyword[i].keyword_term}
						</li>
						{/section}
				</div>
			{* End Keyword list *}
			{/if}
			
			
			
			
		<h2>Description of Module: </h2>
			{if $obj->mModule}
				<div id="module_description">
						
							{$obj->mModule.module_description}
						
				</div>
			{/if}
		</div>
		
		<p>
		<input type="submit" name="delete_module" value="Delete Module" />
		</p>
		
		
	</div>
{* End module *}
</div>
{/if} 
     
 