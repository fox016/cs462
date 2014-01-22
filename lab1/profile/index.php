<?php
	require_once('/var/www/html/cs462/lab1/objects/Header.php');

	$profile = $_GET['user'];
	$current = $email;
	$isOwner = $profile === $current;

	require_once('/var/www/html/cs462/lab1/objects/IO.php');
	$profile_token = getToken($profile);
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
						You have connected to Foursquare (TODO)
					</div>
				<?php
				}
				else if(!$isOwner && $profile_token!="")
				{?>
					<div id='otherCheckinDiv'>
						This user has connected to Foursquare (TODO)
					</div>
				<?php
				}
			?>
		</div>
	</div>
</body>
</html>
