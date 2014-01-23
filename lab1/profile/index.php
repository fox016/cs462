<?php
	require_once('/var/www/html/cs462/lab1/objects/Header.php');

	$profile = $_GET['user'];
	$current = $email;
	$isOwner = $profile === $current;

	require_once('/var/www/html/cs462/lab1/objects/IO.php');
	$profile_token = getToken($profile);

	// Get profile checkin data
	$checkinData = array();
	if($profile_token != "")
	{
		$url = "https://api.foursquare.com/v2/users/self/checkins?access_token=$profile_token&oauth_token=$profile_token";
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
			$checkinData['Error'] = "Connection to Foursquare failed.<br>Response: $response";
		}
		else if($json['meta']['code'] != 200)
		{
			if($json['meta']['code'] == 401 && $json['meta']['errorType'] == "invalid_auth")
			{
				$profile_token = "";
			}
			else
			{
				$checkinData['Error'] = "Connection to Foursquare failed.<br>Status: " . $json['meta']['code'] .
							"<br>Type: " . $json['meta']['errorType'] . "<br>" .
							"Detail: " . $json['meta']['errorDetail'] . "<br>" .
							"URL: " . $callInfo['url'];
			}
		}
		else
		{
			$checkinData = $json;
		}
	}
?>
	<div id='profileWrapper'>
		<div id='profileContent'>
			<div id='profileTitle'>Profile: <?php echo $profile;?></div>
			<?php
				if($isOwner && $profile_token=="")
				{?>
					<div id='connectDiv'>
						<button id='foursquareBtn' onclick='connectToFoursquare()'>Connect to Foursquare</button>
					</div>
				<?php
				}
				else if(!$isOwner && $profile_token=="")
				{?>
					<div id='connectErrorDiv'>
						This user has not connected to Foursquare
					</div>
				<?php
				}
				else if($isOwner && $profile_token!="")
				{?>
					<div id='userCheckinDiv'>
						You have connected to Foursquare<br><br>
						<?php
							if(isset($checkinData['Error']))
							{
								echo $checkinData['Error'];
							}
							else
							{
								$checkins = getDetailedCheckin($checkinData);
								foreach($checkins['checkins'] as $check)
								{?>
									<table class='checkinTable'>
										<tr><th>Time</th><td><?php echo $check['time'];?></td></tr>
										<tr><th>Venue</th><td><?php echo $check['venueName'];?></td></tr>
										<tr><th>Address</th><td><?php echo $check['venueAddress'];?></td></tr>
										<tr><th>City</th><td><?php echo $check['venueCity'];?></td></tr>
										<tr><th>State</th><td><?php echo $check['venueState'];?></td></tr>
										<tr><th>Visit Count</th><td><?php echo $check['visitCount'];?></td></tr>
									</table>
								<?php	
								}
							}
						?>
					</div>
				<?php
				}
				else if(!$isOwner && $profile_token!="")
				{?>
					<div id='otherCheckinDiv'>
						This user has connected to Foursquare<br><br>
						<?php
							if(isset($checkinData['Error']))
							{
								echo $checkinData['Error'];
							}
							else
							{
								$checkins = getLimitedCheckin($checkinData);
								foreach($checkins['checkins'] as $check)
								{?>
									<table class='checkinTable'>
										<tr><th>Time</th><td><?php echo $check['time'];?></td></tr>
										<tr><th>Venue</th><td><?php echo $check['venueName'];?></td></tr>
										<tr><th>City</th><td><?php echo $check['venueCity'];?></td></tr>
										<tr><th>State</th><td><?php echo $check['venueState'];?></td></tr>
									</table>
								<?php	
								}
							}
						?>
					</div>
				<?php
				}
			?>
		</div>
	</div>
</body>
</html>
