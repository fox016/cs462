<?php

// Get user input
$email = $_POST['email'];
$displayName = $_POST['displayName'];
$password = $_POST['password'];

// Validate user input
if(!filter_var($email, FILTER_VALIDATE_EMAIL))
{
	echo "Error: Invalid email ($email)";
	die;
}
if(strlen($displayName) < 1 || strlen($displayName) > 40)
{
	echo "Error: Invalid display name ($displayName). Must be 1-40 characters";
	die;
}
if(strlen($password) < 8 || strlen($password) > 40)
{
	echo "Error: Invalid password ($password). Must be 8-40 characters";
	die;
}

// Read account data from file
require_once('../objects/IO.php');
$accounts = readAccounts();

// Append to account data
$account = array();
$account['email'] = $email;
$account['displayName'] = $displayName;
$account['password'] = $password;
$account['oauth'] = "";
$accounts['Accounts'][] = $account;

// Save account data to file
writeAccounts($accounts);
