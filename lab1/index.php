<?php
	$action = $_POST['action'];
	if($action == "SIGN_IN")
	{
	}

	$user = $_COOKIE['lab_1_user'];
	if($user != "")
	{
		$displayName = "Bob"; // TODO
		$email = 1; // TODO
	}
?>

<!DOCTYPE html>
<html>
<head>
	<title>Nathan Fox - Lab 1</title>
	<link type='text/css' rel='stylesheet' href='css/index.css'>
	<link type='text/css' rel='stylesheet' href='js/jquery-ui/css/no-theme/jquery-ui-1.10.4.custom.css'>
	<script type='text/javascript' src='js/jquery-ui/js/jquery-1.10.2.js'></script>
	<script type='text/javascript' src='js/jquery-ui/js/jquery-ui-1.10.4.custom.min.js'></script>
	<script type='text/javascript' src='js/index.js'></script>
</head>
<body>
	<div id='pageHeader'>
		<table id='headerTable'>
			<tr>
				<td id='title'>Nathan Fox - Lab 1</td>
				<td id='rightHeader'>
					<?php
						if($user == "")
						{?>
							<button id='signBtn' onclick='openSignIn()'>Sign In</button>
						<?php
						}else
						{
							echo "Hello, $displayName&nbsp;&nbsp;";
						?>
							<button id='signBtn' onclick='signOut()'>Sign Out</button>
						<?php
						}
					?>
				</td>
			</tr>
		</table>
	</div>
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
	<div id='signIn' style='display:none'>
		<table>
			<tr>
				<td>Email:</td>
				<td><input type=text id='signEmail'></td>
			</tr>
			<tr>
				<td>Password:</td>
				<td><input type=password id='signPassword'></td>
			</tr>
		</table>
	</div>
	<div id='myAlert' style='display:none'>
		<div id='myAlertText'></div>
	</div>
	<div id='allAccounts' style='display:none'>
		<table id='allAccountsTable'>
			<thead>
				<th>Display Name</th>
				<th>Email</th>
			</thead>
			<tbody>
			</tbody>
		</table>
	</div>
</body>
</html>
