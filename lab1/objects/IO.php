<?php

function readAccounts()
{
	$accountFile = "/var/www/html/cs462/lab1/files/accounts.json";
	$accounts = file_get_contents($accountFile);
	if($accounts === FALSE)
	{
		echo "Error: Could not read from accounts file: $accountFile";
		die;
	}
	$accounts = json_decode($accounts, true);
	if($accounts === NULL)
	{
		echo "Error: Could not decode accounts file";
		die;
	}
	return $accounts;
}

function writeAccounts($accounts)
{
	$accountFile = "/var/www/html/cs462/lab1/files/accounts.json";
	$success = file_put_contents($accountFile, json_encode($accounts));
	if($success === FALSE)
	{
		echo "Error: Could not write to accounts file ($accountFile): " . json_encode($accounts);
		die;
	}
}

