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

// Append to account data

// Save account data to file
