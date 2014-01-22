<?php
	require_once('/var/www/html/cs462/lab1/objects/Header.php');

	$profile = $_GET['user'];
	$current = $email;
	$isOwner = $profile === $current;
?>
	<div id='profileContent'>
		<div id='profileTitle'>Profile: <?php echo $profile;?></div>
	</div>
</body>
</html>
