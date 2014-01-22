/*
 * Opens sign in dialog
 */
function openSignIn()
{
	$("#signIn").dialog({
		draggable: true,
		title: "Sign In",
		modal: true,
		width: 300,
		height: 200,
		resizable: false,
		open: function()
		{
			$("#signEmail").val("");
			$("#signPassword").val("");
		},
		close: function()
		{
			$(this).dialog("destroy");
		},
		buttons:
		[
			{
				text: "Sign In",
				id: "signInBtn",
				click: function()
				{
					signIn();
				}
			},
			{
				text: "Cancel",
				id: "cancelBtn",
				click: function()
				{
					$(this).dialog("close");
				},
			},
		],
	});
}

/*
 * Attempts to sign in using data from UI
 */
function signIn()
{
	$("#myForm").append("<input type='hidden' name='action' id='action' value='SIGN_IN'>");
	$("#myForm").append("<input type='hidden' name='username' id='username' value='" + $("#signEmail").val() + "'>");
	$("#myForm").append("<input type='hidden' name='password' id='password' value='" + $("#signPassword").val() + "'>");
	$("#myForm").submit();
}

/*
 * Clears cookie and refreshes page
 */
function signOut()
{
	$("#myForm").append("<input type='hidden' name='action' id='action' value='SIGN_OUT'>");
	$("#myForm").submit();
}

/*
 * Navigates to profile of user defined by email
 */
function goToProfile(email)
{
	newLoc = location.protocol + '//' + location.host + "/cs462/lab1/profile/?user=" + encodeURIComponent(email);
	console.log(newLoc);
	window.location.href = newLoc;
}

/*
 * Opens account editor dialog
 */
function openAccountEditor()
{
	$("#accountEditor").dialog({
		draggable: true,
		title: "Create New Account",
		modal: true,
		width: 300,
		height: 220,
		resizable: false,
		open: function()
		{
			$("#newEmail").val("");
			$("#newDisplayName").val("");
			$("#newPassword").val("");
		},
		close: function()
		{
			$(this).dialog("destroy");
		},
		buttons:
		[
			{
				text: "Create Account",
				id: "saveBtn",
				click: function()
				{
					createAccount();
				}
			},
			{
				text: "Cancel",
				id: "cancelBtn",
				click: function()
				{
					$(this).dialog("close");
				},
			},
		],
	});
}

/*
 * Calls AJAX script to create account using data from UI
 */
function createAccount()
{
	$.ajax({
		type: 'POST',	
		url: 'ajax/createAccount.php',
		data: {
			email: $("#newEmail").val(),
			displayName: $("#newDisplayName").val(),
			password: $("#newPassword").val(),
		},
		success: function(data) {

			if(data.substring(0,5) == "Error")
			{
				myAlert(data);
				return;
			}

			$("#accountEditor").dialog("close");
			getAllAccounts();
		},
		error: function() {
			myAlert("There was an error creating the account. Please refresh the page and try again");
		},
	});
}

/*
 * Gets publicly visible account data to make table
 */
function getAllAccounts()
{
	$.ajax({
		type: 'POST',	
		url: 'ajax/getAccounts.php',
		data: {
		},
		success: function(data) {

			if(data.substring(0,5) == "Error")
			{
				myAlert(data);
				return;
			}

			var accounts = JSON.parse(data);
			$("#allAccountsTable tbody").html("");
			for(var i = 0; i < accounts.length; i++)
			{
				$("#allAccountsTable tbody").append("<tr onclick='goToProfile(\"" + accounts[i]['email'] + "\")'><td>" + accounts[i]['displayName'] + "</td><td>" + accounts[i]['email'] + "</td></tr>");
			}
			$("#content").html($("#allAccounts").html());
		},
		error: function() {
			myAlert("There was an error reading the accounts. Please refresh the page and try again");
		},
	});
}

/*
 * Handles alerts
 */
var alertQueue = [];
var alertFlag = false;
function myAlert(msg)
{
	if(alertFlag)
	{
		alertQueue.push(msg);
		return;
	}
	alertFlag = true; // Set lock

	$("#myAlertText").html(msg);
	$("#myAlert").dialog({
		title: "Alert",
		resizable: true,
		modal: true,
		height: 200,
		close: function()
		{
			$(this).dialog("destroy");
			alertFlag = false; // Release lock
			if(alertQueue.length > 0)
			{
				myAlert(alertQueue.shift());
			}
		},
		buttons:
		[
			{
				text: "Close",
				id: "cancelBtn",
				click: function()
				{
					$(this).dialog("close");
				},
			},
		],
	});
}

/*
 * Page init
 */
$(document).ready(function()
{
	getAllAccounts();
});
