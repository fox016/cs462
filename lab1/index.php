<?php
	require_once('/var/www/html/cs462/lab1/objects/Header.php');
?>
	<div id='page'>
		<table id='pageTable' cellspacing=0> 
			<tr>
				<td id='leftBar'>
					<table id='actionTable'>
						<tr><td>
							<?php
								if($user == "")
								{?>
									<button id='createBtn' onclick='openAccountEditor()'>Create Account</button>
								<?php
								}else
								{?>
									<button id='createBtn' onclick='goToProfile("<?php echo $email;?>")'>My Profile</button>
								<?php
								}
							?>	
						</td></tr>
					</table>
				</td>
				<td id='content'>
				</td>
			</tr>
		</table>
	</div>
	<div id='accountEditor' style='display:none'>
		<table>
			<tr>
				<td>Email:</td>
				<td><input type=text id='newEmail'></td>
			</tr>
			<tr>
				<td>Display Name:</td>
				<td><input type=text id='newDisplayName'></td>
			</tr>
			<tr>
				<td>Password:</td>
				<td><input type=password id='newPassword'></td>
			</tr>
		</table>
	</div>
	<div id='allAccounts' style='display:none'>
		<div id='accountTableLabel'>User Profiles</div>
		<table id='allAccountsTable' cellspacing=0>
			<thead>
				<th>Display Name</th>
				<th>Email</th>
			</thead>
			<tbody>
			</tbody>
		</table>
	</div>
	<script type='text/javascript'>
		$(document).ready(function()
		{
			getAllAccounts();
		});
	</script>
</body>
</html>
