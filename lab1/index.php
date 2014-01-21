<?php
	$user = $_COOKIE['lab_1_user'];
	if($user != "")
	{
		$displayName = "Bob"; // TODO
		$profileId = 1; // TODO
	}
?>

<!DOCTYPE html>
<html>
<head>
	<title>Nathan Fox - Lab 1</title>
	<link type='text/css' rel='stylesheet' href='css/index.css'>
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
									<button id='createBtn' onclick='goToProfile("<?php echo $profileId;?>")'>My Profile</button>
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
				<td><input type=text id='newPassword'></td>
			</tr>
		</table>
	</div>
</body>
</html>
