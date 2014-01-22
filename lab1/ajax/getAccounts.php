<?php

// Read account data from file
require_once('../objects/IO.php');
$accounts = readAccounts();

// Send limited account data to browser
$table = array();
foreach($accounts['Accounts'] as $account)
{
	$item = array();
	$item['email'] = $account['email'];
	$item['displayName'] = $account['displayName'];
	$item['oauth'] = $account['oauth'];
	$table[] = $item;
}
echo json_encode($table);
