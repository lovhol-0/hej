<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
<!-- <meta charset="ISO-8859-1"> -->
<!-- <meta charset="utf-8"> -->
<title>Rapportera betyg</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js"></script>
<script
	src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>

<script
	src="https://cdn.datatables.net/1.10.16/js/dataTables.bootstrap4.min.js"></script>


<script type="text/javascript">
	$(document).ready(function() {
		$('#example').DataTable();
	});
	
	var url = "http://localhost:8085/canvas/";
	var url2 = "http://localhost:8085/canvas/{kurskod}";
	$(function() {
	    canvasList();
		kurskodList();
	    $('button[type=button]').click(function(e) {
	        e.preventDefault();
	        // alert($('form[name=canvasForm]').serialize());
	        $.post({
	            type: "POST",
	            url: url,
	            data: $('form[name=canvasForm]').serialize(),
	            dataType: "text",
	            success: function(response) {
	                $("#success_id").show().fadeOut(5000);
	                canvasList();
	                $("input[type=text], textarea").val("");
	            },
	            error: function(jqXHR, textStatus, errorThrown) {
	                console.log(textStatus, errorThrown);
	                $("#error_id").show().fadeOut(5000);
	            }
	        })
	    });
	});

	function getModifyUppgifter() {
		var kurskod = document.getElementById("selectKurskod").value;
  		console.log(kurskod);
		modifyUppgifter(kurskod);
	};

	function modifyUppgifter(kurskod) {
		var alreadyUsed = [];
		$.ajax({
	        type: "GET",
	        url: url + "kurskod/" + kurskod,
	        dataType: "json",
	        success: function(response) {
	            var table = '<table id=example class=table table-striped table-bordered cellspacing=0 width=100%>' +
	                '<thead> <tr> <th>Kurskod</th> <th>Uppgift i Canvas</tr> </thead>' +
					'<tr> <td> <select id="selectKurskod" onchange="getModifyUppgifter()">';
						
	            $.each(response, function(key, canvas) {
					if (alreadyUsed.includes(canvas.kurskod)) {
					} else {
						alreadyUsed.push(canvas.kurskod);
						table += "<option>" + canvas.kurskod + "</option>";
					};
	            });

				

				table += '</select></td><td><select id="selectUppgift">';
					$.each(response, function(key, canvas) {
	                table += "<option>" + canvas.uppgift + "</option>";
	            });

	            table += '</select></td></tr></table>';
	            $("#uppgiftTableContainer").html(table);
	        }
	    });
	};

	function kurskodList() {
	    var msg_data;
		var alreadyUsed = [];
	    $.ajax({
	        type: "GET",
	        url: url,
	        dataType: "json",
	        success: function(response) {
	            var table = '<table id=example class=table table-striped table-bordered cellspacing=0 width=100%>' +
	                '<thead> <tr> <th>Kurskod</th> <th>Uppgift i Canvas</tr> </thead>' +
					'<tr> <td> <select id="selectKurskod" onchange="getModifyUppgifter()">';
						
	            $.each(response, function(key, canvas) {
					if (alreadyUsed.includes(canvas.kurskod)) {
					} else {
						alreadyUsed.push(canvas.kurskod);
						table += "<option>" + canvas.kurskod + "</option>";
					};
	            });

				

				table += '</select></td><td><select id="selectUppgift">';
					$.each(response, function(key, canvas) {
	                table += "<option>" + canvas.uppgift + "</option>";
	            });

	            table += '</select></td></tr></table>';
	            $("#kurskodTableContainer").html(table);
	        }
	    });
	}

	function canvasList() {
	    var msg_data;
	    $.ajax({
	        type: "GET",
	        url: url,
	        dataType: "json",
	        success: function(response) {
	            var table = '<table id=example class=table table-striped table-bordered cellspacing=0 width=100%>' +
	                '<thead> <tr> <th>Id</th> <th>Namn</th> <th>Grade</th> <th>Kurskod</th> <th>Edit</th> <th>Delete</th> </tr> </thead>' +
	                '<tfoot> <tr> <th>Id</th> <th>Namn</th> <th>Grade</th> <th>Kurskod</th> <th>Edit</th> <th>Delete</th> </tr> </tfoot><tbody id="canvas-list">';
	            $.each(response, function(key, canvas) {
	                table += "<tr>" +
	                    "<td>" + canvas.id + "</td>" +
	                    "<td>" + canvas.namn + "</td>" +
	                    "<td>" + canvas.grade + "</td>" +
	                    "<td><select><option>" + canvas.kurskod + "</option></select></td>" +
	                    "<td><a href='#' onclick='javascript:editCanvas(" + canvas.id + ");'>edit</a></td>" +
	                    "<td><a href='#' onclick='javascript:deleteCanvas(" + canvas.id + ");'>delete</a></td>" +
	                    "</tr>";

	            });
	            table += '</table>';
	            $("#tableContainer").html(table);
	        }
	    });
	}



	function deleteCanvas(id) {
	    //alert(id);
	    $.ajax({
	        type: "DELETE",
	        url: url + id,
	        dataType: "text",
	        success: function(response) {
	            $("#success_id").show().fadeOut(5000);
	            canvasList();
	        },
	        error: function(jqXHR, textStatus, errorThrown) {
	            $("#error_id").show().fadeOut(5000);
	            console.log(textStatus, errorThrown);
	        }
	    })
	}

	function editCanvas(id) {
	    $.ajax({
	        type: "GET",
	        url: url + id,
	        dataType: "json",
	        success: function(response) {
	            $("#idInput").html("<input id='id' name='id' type='hidden' class='form-control input-md' value=" + response.id + ">")
	            $("#namn").val(response.namn);
	            $("#grade").val(response.grade);
	            $("#kurskod").val(response.kurskod);
	            canvasList();
	        },
	        error: function(jqXHR, textStatus, errorThrown) {
	            console.log(textStatus, errorThrown);
	        }
	    })
	}
</script>
</head>
<body>

	<div class="container">
		
		<!-- <form class="form-horizontal mx-auto" name="canvasForm" method="post">
			<strong>Canvas Form </strong>
			<div class="form-group" id="idInput"></div>
			<div class="form-group">
				<label class="col-md-4 control-label" for="namn">Namn</label>
				<div class="col-md-4">
					<input id="namn" name="namn" type="text" placeholder="Namn"
						class="form-control input-md" required="required">

				</div>
			</div>

			<div class="form-group">
				<label class="col-md-4 control-label" for="grade">grade</label>
				<div class="col-md-4">
					<input id="grade" name="grade" type="text"
						placeholder="grade" class="form-control input-md"
						required="required">

				</div>
			</div>

			<div class="form-group">
				<label class="col-md-4 control-label" for="kurskod">Kurskod</label>
				<div class="col-md-4">
					<input id="kurskod" name="kurskod" type="text" placeholder="Kurskod"
						class="form-control input-md" required="required">

				</div>
			</div>

			<div class="form-group">
				<label class="col-md-4 control-label" for=""></label>
				<div class="col-md-4">
					<button id="CanvasFormSubmit" type="button"
						name="canvasFormSubmit" class="btn btn-success">Submit</button>
				</div>
			</div>
		</form>
		<div class="alert alert-success" id="success_id" style="display: none">
			<strong>Success!</strong> Data saved Successfully.
		</div>
		<div class="alert alert-danger" id="error_id" style="display: none">
			<strong>Danger!</strong> Something went wrong! Try again.
		</div> -->
		<h1>Rapportera endast betyg</h1>
		<p>Tre urvalsfält visas: Kurskod, Uppgift i Canvas och Modul i Ladok. Välj enligt det du vill rapportera.</p>
		<div class="row" id="kurskodTableContainer"></div>
		<div class="row" id="uppgiftTableContainer"></div>
		<!-- <div class="row" id="tableContainer"></div> -->
	</div>
</body>
</html>