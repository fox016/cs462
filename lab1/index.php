<?php
	$user = "";
	$loginFailed = FALSE;
	$action = $_POST['action'];

	// Sign In
	if($action == "SIGN_IN")
	{
		require_once('/var/www/html/cs462/lab1/objects/Auth.php');
		$account = signIn($_POST['username'], $_POST['password']);
		if($account === NULL)
		{
			$loginFailed = TRUE;
		}
		else
		{
			$displayName = $account['displayName'];
			$email = $account['email'];
			$oauth = $account['oauth'];
			$user = $email;
		}
	}

	// Sign Out
	else if($action == "SIGN_OUT")
	{
		require_once('/var/www/html/cs462/lab1/objects/Auth.php');
		signOut();
	}

	// No Action
	else
	{
		$user = $_COOKIE['lab_1_email'];
		if($user != "")
		{
			$displayName = $_COOKIE['lab_1_display'];
			$email = $_COOKIE['lab_1_email'];
			$oauth = $_COOKIE['lab_1_oauth'];
		}
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
	<?php
		if($loginFailed){?>
			<script type='text/javascript'>$(document).ready(function(){myAlert("Login Failed");});</script>
		<?php
		}
	?>
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
	<form name='myForm' id='myForm' method='POST'>
	</form>
</body>
</html>
