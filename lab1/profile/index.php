<?php
	require_once('/var/www/html/cs462/lab1/objects/Header.php');

	$profile = $_GET['user'];
	$current = $email;
	$isOwner = $profile == $current;
?>
	<div id='profileWrapper'>
		<div id='profileContent'>
			<div id='profileTitle'>Profile: <?php echo $profile;?></div>
			<?php
				if($isOwner && $oauth=="")
				{?>
					<div id='connectDiv'>
						<button id='foursquareBtn' onclick='connectToFoursquare()'>Connect to Foursquare</button>
					</div>
				<?php
				}
				if(!$isOwner && $oauth=="")
				{?>
					<div id='connectErrorDiv'>
						This user has not connected to Foursquare
					</div>
				<?php
				}
			?>
		</div>
	</div>
</body>
</html>
