{* module_leaders_list.tpl *}
{load_presentation_object filename="module_leaders_list" assign="obj"}

{if $obj->mModuleLeadersList}
	<li>
		<a href="?op=Random"> <img src="./images/random.png" WIDTH=20 HEIGHT=20 /></a> {*Add ?op= *}
	</li>
	<table id='GridView1' cellspacing='0' cellpadding='4' border='2' width='750'>
	<thead>
	<tr style='color:Black;background-color:DarkGreen;font-weight:bold;font-size:large;'>
		<th scope='col'>Leader</th>
		<th scope='col'>Modules</th>
	</tr>
	</thead>
	<tbody>
	{* Loop through the list of leaders *}
	{section name=i loop=$obj->mModuleLeadersList}
	<tr class="{cycle values="odd,even"}">
		{* Generate a new leaders in the list *}
		<td>
            {$obj->mModuleLeadersList[i].module_leader}
		</td>
        <td>
        	<table>
            <tr>
            	{section name=j loop=$obj->mLeadersModules[i]}
                <td>
                    {if $obj->mLeadersModules[i][j].module_image neq ""}
								<div class="image">     
								<a href="?op=Details&module_id={$obj->mLeadersModules[i][j].module_id}">      
								<img src="./images/{$obj->mLeadersModules[i][j].module_image}" WIDTH=60 HEIGHT=60
										alt="{$obj->mLeadersModules[i][j].module_title}"  
											/a>										
								</div>
							</div>				
						</div>
					{/if}
                </td>
                {/section}
            </tr>
            </table>
        </td>
	</tr>
	{/section}
	</tbody>
	</table>
{* End leaders list *}
{/if}


