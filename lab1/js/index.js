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
				alert(data);
				return;
			}

			$("#accountEditor").dialog("close");
		},
		error: function() {
			// TODO
		},
	});
}
