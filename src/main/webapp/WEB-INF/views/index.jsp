<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
	<link rel="stylesheet" href="styles.css">
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
	var url2 = "http://localhost:8085/ladok/";
	$(function() {
		kurskodList();
	    $('submit-button').click(function(e) {
			console.log($('form[name=ladokPostLove]').serialize());
			console.log("hej")
	        e.preventDefault();
	        // alert($('form[name=canvasForm]').serialize());
	        $.post({
	            type: "POST",
	            url: url2,
	            data: $('form[name=ladokPost]').serialize(),
	            dataType: "text",
	            success: function(response) {
	                $("#success_id").show().fadeOut(5000);
	                modifyCanvas();
	                $("input[type=text], textarea").val("");
	            },
	            error: function(jqXHR, textStatus, errorThrown) {
	                console.log(textStatus, errorThrown);
	                $("#error_id").show().fadeOut(5000);
	            }
	        })
	    });
	});

	function setKurskod() {
		var kurskod = document.getElementById("selectKurskod").value;
  		console.log(kurskod);
		modifyUppgifter(kurskod);
		modifyModul(kurskod);
	};

	function getKurskod() {
		var kurskod = document.getElementById("selectKurskod").value;
		console.log(kurskod);
		return kurskod;
	}

	function setUppgift() {
		var uppgift = document.getElementById("selectUppgift").value;
		var kurskod = getKurskod();
  		console.log(kurskod, uppgift);
		modifyCanvas(kurskod, uppgift);
	};

	function modifyModul(kurskod) {
		var kurskod = document.getElementById("selectKurskod").value;
		var alreadyUsed = [];
		$.ajax({
	        type: "GET",
	        url: url2 + "kurskod/" + kurskod,
	        dataType: "json",
	        success: function(response) {
	            var td = '<td><select id="selectModul"><option value="" selected disabled hidden>-</option>';
					$.each(response, function(key, ladok) {
						if (alreadyUsed.includes(ladok.modul_kod)) {
						} else {
							alreadyUsed.push(ladok.modul_kod);
							td += "<option>" + ladok.modul_kod + "</option>";
						};
	                	
	            });

	            td += '</select></td>';
	            $("#modulTableContainer").html(td);
	        }
	    });
	};

	function modifyUppgifter(kurskod) {
		var kurskod = document.getElementById("selectKurskod").value;
		var alreadyUsed = [];
		$.ajax({
	        type: "GET",
	        url: url + "kurskod/" + kurskod,
	        dataType: "json",
	        success: function(response) {
	            var td = '<td><select id="selectUppgift" onchange="setUppgift()"><option value="" selected disabled hidden>-</option>';
					$.each(response, function(key, canvas) {
						if (alreadyUsed.includes(canvas.uppgift)) {
						} else {
							alreadyUsed.push(canvas.uppgift);
							td += "<option>" + canvas.uppgift + "</option>";
						};
	                	
	            });

	            td += '</select></td>';
	            $("#uppgiftTableContainer").html(td);
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
	            var td = '<td><select id="selectKurskod" onchange="setKurskod()"><option value="" selected disabled hidden>-</option>';
						
	            $.each(response, function(key, canvas) {
					if (alreadyUsed.includes(canvas.kurskod)) {
					} else {
						alreadyUsed.push(canvas.kurskod);
						td += "<option>" + canvas.kurskod + "</option>";
					};
	            });
				

	            td += '</select></td>';
	            $("#kurskodTableContainer").html(td);
	        }
	    });
	}

	function modifyCanvas(kurskod, uppgift) {
		console.log(kurskod, uppgift);
		var alreadyUsed = [];
		$.ajax({
	        type: "GET",
	        url: url + "list/" + kurskod + "/" + uppgift,
	        dataType: "json",
	        success: function(response) {
	            var tdNamn = '';
				var tdGrade = '';
				var tdBetyg = '';
				var tdDatum = '';
				var tdStatus = '';
				var tdInfo = '';
				var tdKnapp = '';
					$.each(response, function(key, canvas) {
						
							tdNamn +=  "<tr><td>" + canvas.namn + "</td></tr>";
							tdGrade +=  "<tr><td>" + canvas.grade + "</td></tr>";
							tdBetyg +=  "<tr><td><select><option>" + canvas.grade + "</option></select></td></tr>";
							tdDatum +=  "<tr><td><input type='date'></input></td></tr>";
							tdStatus +=  "<tr><td></td></tr>";
							tdInfo +=  "<tr><td></td></tr>";
							tdKnapp += 	"<tr><td><button type='button' onclick='postLadok()'>Submit</button></td></tr>";	
	                	
	            });
	            $("#canvasNamnTableContainer").html(tdNamn);
				$("#canvasGradeTableContainer").html(tdGrade);
				$("#canvasBetygTableContainer").html(tdBetyg);
				$("#canvasDatumTableContainer").html(tdDatum);
				$("#canvasStatusTableContainer").html(tdStatus);
				$("#canvasInfoTableContainer").html(tdInfo);
				$("#canvasKnappTableContainer").html(tdKnapp);
	        }
	    });
	};




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
	<nav class="navbar-light">
		<div class="container-fluid navbar-brand">
			<div class="container">
			<img src="images/ladoklogga.JPG" alt="Logo">
			</div>
		</div>
	  </nav>
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
		<h2>Rapportera endast betyg</h2>
		<p>Tre urvalsfält visas: Kurskod, Uppgift i Canvas och Modul i Ladok. Välj enligt det du vill rapportera.</p>
		<div class="row">
			<table class=table table-striped table-dark table-bordered cellspacing=0 width=100%>
				<thead> <tr> <th>Kurskod</th> <th>Uppgift i Canvas</th> <th>Modul i Ladok</th></tr> </thead>
				<tr> 
					<td id="kurskodTableContainer"></td>
					<td id="uppgiftTableContainer"></td>
					<td id="modulTableContainer"></td>
				</tr> </table>
		</div>
		<form name="ladokPostLove">
		<div class="row">
			
			<table class=table table-striped table-bordered table-dark cellspacing=0 width=100%>
				<thead> <tr>
					<th>Namn</th>
					<th>Omdöme i Canvas</th>
					<th>Betyg i Ladok</th>
					<th>Examinationsdatum</th>
					<th>Status</th>
					<th>Information</th>
				</tr> </thead>
				<tr>
					
					<td id="canvasNamnTableContainer"></td>
					<td id="canvasGradeTableContainer"></td>
					<td id="canvasBetygTableContainer"></td>
					<td id="canvasDatumTableContainer"></td>
					<td id="canvasStatusTableContainer"></td>
					<td id="canvasInfoTableContainer"></td>
					<td id="canvasKnappTableContainer"></td>
				
				</tr> 
		</table>
	
		</div>
		<button type="button" class="btn btn-primary btn-lg submit-button">Submit</button>
	
		
	</form>
		<!-- <div class="row" id="kurskodTableContainer"></div>
		<div class="row" id="uppgiftTableContainer"></div> -->
		<!-- <div class="row" id="tableContainer"></div> -->
	</div>

	<nav class="navbar fixed-bottom bg-light">
		<div class="container-fluid">
		  <p class="navbar-brand">Nya Coola Canvas</a>
		</div>
	  </nav>
</body>
</html>