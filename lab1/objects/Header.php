<?php
	$user = "";
	$loginFailed = FALSE;
	$action = $_POST['action'];
	$code = $_REQUEST['code'];

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

	// Get and store oauth token from code, if code is provided
	if($code != "")
	{
		require_once('/var/www/html/cs462/lab1/objects/IO.php');
		$url = "https://foursquare.com/oauth2/access_token" .
			"?client_id=F2GWQRS2WTWV3YRD5OEHZQGKDIKYWQX1EJ3QZNTBBGFXUK1B" .
			"&client_secret=JIWAXMG01EX0KNXCBDMPTA1TRPCIIA13VD3DTON4OSVRMKHI" .
			"&grant_type=authorization_code" .
			"&redirect_uri=" . urlencode("http://ec2-54-224-121-158.compute-1.amazonaws.com/cs462/lab1/") .
			"&code=$code";
		$call = curl_init($url);
		curl_setopt($call, CURLOPT_SSL_VERIFYPEER, false);
		curl_setopt($call, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($call, CURLOPT_HTTPGET, true);
		$response = curl_exec($call);
		$callInfo = curl_getinfo($call);
		curl_close($call);
		$json = json_decode($response, true);
		if($json === NULL)
		{
			echo "Error: Could not get oauth token.<br>";
			echo "URL: $url<br>";
			echo "Response: $response<br>";
			echo json_encode($callInfo) . "<br>";
			die;
		}
		setcookie("lab_1_oauth", $json['access_token'], 0, '/');
		$oauth = $json['access_token'];
		setToken($email, $json['access_token']);
	}
?>

<!DOCTYPE html>
<html>
<head>
	<title>Nathan Fox - Lab 1</title>
	<link type='text/css' rel='stylesheet' href='/cs462/lab1/css/index.css'>
	<link type='text/css' rel='stylesheet' href='/cs462/lab1/js/jquery-ui/css/no-theme/jquery-ui-1.10.4.custom.css'>
	<script type='text/javascript' src='/cs462/lab1/js/jquery-ui/js/jquery-1.10.2.js'></script>
	<script type='text/javascript' src='/cs462/lab1/js/jquery-ui/js/jquery-ui-1.10.4.custom.min.js'></script>
	<script type='text/javascript' src='/cs462/lab1/js/index.js'></script>
	<?php
		if($loginFailed){?>
			<script type='text/javascript'>$(document).ready(function(){myAlert("Login Failed");});</script>
		<?php
		}
	?>
</head>
<body>
	<form name='myForm' id='myForm' method='POST' style='display:none'>
	</form>
	<div id='myAlert' style='display:none'>
		<div id='myAlertText'></div>
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
	<div id='pageHeader'>
		<table id='headerTable'>
			<tr>
				<td id='title' onclick='goHome()'>Nathan Fox - Lab 1</td>
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
