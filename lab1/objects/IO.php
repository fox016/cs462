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

function setToken($email, $token)
{
	$accounts = readAccounts();
	$index = 0;
	$found = FALSE;
	foreach($accounts['Accounts'] as $acc)
	{
		if($acc['email'] == $email)
		{
			$found = TRUE;
			break;
		}
		$index++;
	}
	if(!$found) return;
	$accounts['Accounts'][$index]['oauth'] = $token;
	writeAccounts($accounts);
}

function getToken($email)
{
	$accounts = readAccounts();
	foreach($accounts['Accounts'] as $acc)
	{
		if($acc['email'] == $email)
			return $acc['oauth'];
	}
	return "";
}

function getDetailedCheckin($data)
{
	$output = array();
	$output['checkins'] = array();
	$output['count'] = $data['response']['checkins']['count'];
	foreach($data['response']['checkins']['items'] as $check)
	{
		$item = array();
		$item['time'] = date("m-d-Y g:i A", $check['createdAt']);
		$item['venueName'] = $check['venue']['name'];
		$item['venueAddress'] = $check['venue']['location']['address'];
		$item['venueCity'] = $check['venue']['location']['city'];
		$item['venueState'] = $check['venue']['location']['state'];
		$item['visitCount'] = $check['venue']['beenHere']['count'];
		$output['checkins'][] = $item;
	}
	return $output;
}

function getLimitedCheckin($data)
{
	$output = array();
	$output['checkins'] = array();
	$output['count'] = min(1, $data['response']['checkins']['count']);
	foreach($data['response']['checkins']['items'] as $check)
	{
		$item = array();
		$item['time'] = date("m-d-Y", $check['createdAt']);
		$item['venueName'] = $check['venue']['name'];
		$item['venueCity'] = $check['venue']['location']['city'];
		$item['venueState'] = $check['venue']['location']['state'];
		$output['checkins'][] = $item;
		break;
	}
	return $output;
}
