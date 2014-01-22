<?php

function signIn($username, $password)
{
	require_once('/var/www/html/cs462/lab1/objects/IO.php');
	$accounts = readAccounts();

	foreach($accounts['Accounts'] as $acc)
	{
		if($acc['email'] == $username && $acc['password'] == $password)
		{
			// Set cookie
			setcookie("lab_1_display", $acc['displayName'], 0, '/');
			setcookie("lab_1_email", $acc['email'], 0, '/');
			setcookie("lab_1_oauth", $acc['oauth'], 0, '/');
			return $acc;
		}
	}
	return NULL;
}

function signOut()
{
	setcookie("lab_1_display", null, time()-3600, '/');
	setcookie("lab_1_email", null, time()-3600, '/');
	setcookie("lab_1_oauth", null, time()-3600, '/');
}
