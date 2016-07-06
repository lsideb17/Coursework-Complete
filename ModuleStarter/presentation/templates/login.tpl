{* smarty *}
{config_load file="site.conf"}
{load_presentation_object filename="login" assign="obj"}
<div>
	<h2 style="color:red">Login</h2>
	<form method="post" action="./moduleadmin.php" id="loginForm">
	<div>
		{if $obj->mLoginMessage neq ""}
			<p class="error">{$obj->mLoginMessage}</p>
		{/if}    
		<p>
			<label for="username">Username:</label>
			<input type="text" name="username" size="35" />
			<label for="password">Password:</label>
			<input type="password" name="password" size="35" />
			<input type="submit" name="submit" value="Login" />
		</p>        
	</div>
	</form>
</div>
