<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
	<style>
		.table
		{
			display:table;
			border-collapse:separate;
			border-spacing:2px;
		}
		.thead
		{
			display:table-header-group;
			color:white;
			font-weight:bold;
			background-color:grey;
		}
		.tbody
		{
			display:table-row-group;
		}
		.tr
		{
			display:table-row;
		}
		.td
		{
			display:table-cell;
			border:1px solid black;
			padding:1px;
			width: 14%;
		}
		.tr.editing .td INPUT
		{
			width:100px;
		}
		</style>
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
	var url3 = "http://localhost:8085/its/studentid/";
	$(function() {
		kurskodList();
	    $('button[type=button]').click(function(e) {
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

	function getModul_kod() {
		var modul_kod = document.getElementById("selectModul").value;
		console.log(modul_kod);
		return modul_kod;
	}

	function setUppgift() {
		var uppgift = document.getElementById("selectUppgift").value;
		var kurskod = getKurskod();
  		console.log(kurskod, uppgift);
		renderStudents(kurskod, uppgift);
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

	function renderTable(){
		var table = "";
		table = "<div class='table'><div class='thead'><div class='tr'><div class='td'>Namn</div><div class='td'>Omdöme i Canvas</div><div class='td'>Betyg i Ladok</div><div class='td'>Examinationsdatum</div><div class='td'>Status</div><div class='td'>Information</div><div class='td'></div></div></div>";
		table += "<div class='tbody' id='data'>";
		table += "</div></div>";
		return table;
	}

	function renderStudents(kurskod, uppgift){
		document.getElementById('container').innerHTML = renderTable();
		console.log(kurskod, uppgift);
		var alreadyUsed = [];
		$.ajax({
	        type: "GET",
	        url: url + "list/" + kurskod + "/" + uppgift,
	        dataType: "json",
	        success: function(response) {
				
				var rowForm = '';
				var i = 0
					$.each(response, function(key, canvas) {


							
							
							i += 1
							console.log(i)
							rowForm += "<form class='tr' name='testName'>"
							rowForm += "<div class='td' value='"+ canvas.studentid + "' id='oPerson_nr" + i + "'>" + canvas.namn + "</div>"
							rowForm += "<div class='td' id='oKurskod'>" + canvas.grade + "</div>"
							rowForm += "<div class='td' id='oBetyg'><select id='betygSelect" + i + "'><option>" + canvas.grade + "</option></select></div>"
							rowForm += "<div class='td' ><input type='date' id='oDatum" + i + "' ></input>" +  "</div>"
							rowForm += "<div class='td' id='oStatus'><select id='statusSelect" + i + "'><option value='' selected disabled hidden>-</option><option>Utkast</option><option>Klarmarkerad</option><option>Attesterad</option><option>Hinder</option></select>" +  "</div>"
							rowForm += "<div class='td' id='oModul_kod'>" + "-" +  "</div>"	
							rowForm += "<div class='td action'><button type='button' onclick='getPerson_nr("+i+")'>send it</button>" +  "</div>"	
							rowForm += "</form>"

	                	
	            });
				document.getElementById('data').innerHTML = rowForm;
	        }
	    });
	}

	function getPerson_nr(i){
		var i = i;
		var studentid = document.getElementById("oPerson_nr" + i).getAttribute("value");
		console.log("bu");
		var person_nr = '';
		$.ajax({
	        type: "GET",
	        url: url3 + studentid,
	        dataType: "json",
	        success: function(response) {
				
				
				console.log(studentid);
				console.log("personnummer");
				console.log("hej");
				console.log("personnummer");
				console.log("då");
	            
					$.each(response, function(key, its) {
						console.log("ga");
						person_nr = its.person_nr
						console.log(person_nr);
						console.log("personnummer");
	                	
	            });

	            postRowLadok(i, person_nr);
	        }
	    });

	}

	function postRowLadok(i, person_nr){
		var i = i;
		var person_nr = person_nr;
		var oPerson_nr = person_nr;
		console.log("här");
		console.log(oPerson_nr);
		var oKurskod = getKurskod();
		console.log(oKurskod);
		var oModul_kod = getModul_kod();
		console.log(oModul_kod);
		var oDatum = document.getElementById("oDatum" + i).value;
		console.log(oDatum);
		var oBetyg = document.getElementById("betygSelect" + i).value;
		console.log(oBetyg);
		var oStatus = document.getElementById("statusSelect" + i).value;
		console.log(oStatus);
		$.ajax({
	            type: "POST",
	            url: url2,
	            data: JSON.stringify({person_nr: oPerson_nr, kurskod: oKurskod, modul_kod: oModul_kod, datum: oDatum, betyg: oBetyg, status: oStatus}),
				contentType: "application/json; charset=utf-8",
				dataType: "json",
	            success: function(response) {
	                $("#success_id").show().fadeOut(5000);
	                productList();
	                $("input[type=text], textarea").val("");
	            },
	            error: function(jqXHR, textStatus, errorThrown) {
	                console.log(textStatus, errorThrown);
	                $("#error_id").show().fadeOut(5000);
	            }
	        });

	}

	




	
</script>

</head>
<body>

	<div class="container">
		<h1>Rapportera endast betyg</h1>
		<p>Tre urvalsfält visas: Kurskod, Uppgift i Canvas och Modul i Ladok. Välj enligt det du vill rapportera.</p>
		<div class="row">
			<table class=table table-striped table-bordered cellspacing=0 width=100%>
				<thead> <tr> <th>Kurskod</th> <th>Uppgift i Canvas</th> <th>Modul i Ladok</th></tr> </thead>
				<tr> 
					<td id="kurskodTableContainer"></td>
					<td id="uppgiftTableContainer"></td>
					<td id="modulTableContainer"></td>
				</tr> </table>
		</div>
		

		
		<div id='container'></div>

		
		

	</div>
</body>
</html>