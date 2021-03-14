<%	
'	IMPORTANT!!!
' 	TO-DO: store information from DB ps_afficherStatistique(given id) to array dc 

'	Dim conn
'	Set conn = Server.CreateObject("ADODB.Connection")
'	conn.Open "Provider=SQLOLEDB;Data Source=IBRAHIMELMO0569; Database=kheops_ola; Initial Catalog=kheops_ola;User ID=kheops_ola;Password=Ola2.ES#2020"
'	obj.Open

	Dim dc(20)
	dc(0) = "Question 10?"
	dc(1) =  Array("Reponse 1", "Reponse 2", "Reponse 3")
	dc(2) = Array(203,200,33)
	dc(3) = "Test test test 2?"
	dc(4) =  Array("Reponse 1", "Reponse 2", "Reponse 3")
	dc(5) = Array(201,203,33)
	dc(6) = "Test test test 3?"
	dc(7) =  Array("Reponse 1", "Reponse 2", "Reponse 3", "Reponse 4")
	dc(8) = Array(201,283,333,222)
	dc(9) = "Test test test 4?"
	dc(10) =  Array("Reponse 1", "Reponse 2", "Reponse 3", "Reponse 4")
	dc(11) = Array(201,223,333,122)
	dc(12) = "Test test test 5?"
	dc(13) =  Array("Reponse 1", "Reponse 2", "Reponse 3")
	dc(14) = Array(201,233,333)
	dc(15) = "Test test test 6?"
	dc(16) =  Array("Reponse 1", "Reponse 2", "Reponse 3")
	dc(17) = Array(201,213,333)
	dc(18) = "Test test test 7?"
	dc(19) =  Array("Reponse 1", "Reponse 2", "Reponse 3")
	dc(20) = Array(201,233,333)
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
	<script type="text/javascript" src="https://html2canvas.hertzen.com/dist/html2canvas.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.2/jspdf.debug.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-colorschemes"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<link href="https://fonts.googleapis.com/css?family=Lobster"rel="stylesheet"type="type/css">
    <title>Stats</title>
	    <style>
			body {
				background-image: url('back.png');
			}
            html, h1, .container {
				max-width: 800px;
                margin: auto;
            }
			h1 {
				font-size: 46px;
				font-family: monospace;
			}
			.print {
				background-color: #fff;
				border: 2px solid black;
			}
			hr { 
				border-width: 5px;
			}

        </style>
</head>

<body>
	<div class="print" id="toPDF">
    <script>
	var store = new Array();
	<% 
		dim idx
		for idx = 0 to uBound(dc) step 3
	%>
		store[<%=idx%>] = '<%= dc(idx) %>'; 
		store[<%=idx+1%>] = <%= "['" & Join(dc(idx+1), "','") & "']" %>; 
		store[<%=idx+2%>] = <%= "[" & Join(dc(idx+2), ",") & "]" %>; 
	<%next%>
	for(i = 0; i<store.length;i+=3) {
		document.write("<div class='print-wrap-page"+i+"'>");
		document.write("<br><br><center><h1>" + store[i] + "</h1><br></center>")
		var dataLabel = store[i+1]; 
		var dataDatasets = store[i+2]; 
		let idd = "myChart" + i;
		document.write("<div class='container'> <canvas id=" + idd + "></canvas> </div>")
		document.write("<div class='container'> <canvas id=" + idd+1 + "></canvas> </div>")
		let myChart = document.getElementById(idd).getContext('2d')
		let myChart2 = document.getElementById(idd+1).getContext('2d')
		let massPopChart = new Chart(myChart, {
			type: 'doughnut', // bar, horizontalBar, pie, line ,doughnut, radar, polarArea
			data: {
				labels: dataLabel,
				datasets:[{
					label:'votes',
					data: dataDatasets,
				}],
			},
			options: {
				plugins: {
					colorschemes: {
						scheme: 'brewer.Paired12'
					}
				}
			}	
		});
		let massPopChart2 = new Chart(myChart2, {
			type: 'bar', // bar, horizontalBar, pie, line ,doughnut, radar, polarArea
			data: {
				labels: dataLabel,
				datasets:[{
					label:'votes',
					data: dataDatasets,
				}],
			},
			options: {
				scales: {
					yAxes: [{
						ticks: {
							beginAtZero: true
						}
					}]
				},
				plugins: {
					colorschemes: {
						scheme: 'brewer.Paired12'
					}
				}
			}	
		})
		document.write("<br><hr></div>");
	}
    </script>
	</div>
<br>
<button id="cmd">Telecharger</button>
<script type="text/javascript">

$('#cmd').click(function () {
	
	window.scrollTo(0,0);     
	var HTML_Width = $(".print").width();
		var HTML_Height = $(".print").height();
		var top_left_margin = 15;
		var PDF_Width = HTML_Width+(top_left_margin*2);
		var PDF_Height = (PDF_Width*1.5)+(top_left_margin*2);
		PDF_Height = 1900;
		var canvas_image_width = HTML_Width;
		var canvas_image_height = HTML_Height;
		var totalPDFPages = Math.ceil(HTML_Height/PDF_Height)-1;
		html2canvas($(".print")[0],{allowTaint:true}).then(function(canvas) {
			canvas.getContext('2d');
			console.log(canvas.height+"  "+canvas.width);
			var imgData = canvas.toDataURL("image/jpeg", 1.0);
			var pdf = new jsPDF('p', 'pt',  [PDF_Width, PDF_Height]);
		    pdf.addImage(imgData, 'JPG', top_left_margin, top_left_margin,canvas_image_width,canvas_image_height);
			for (var i = 1; i <= totalPDFPages; i++) { 
				pdf.addPage(PDF_Width, PDF_Height);
				pdf.addImage(imgData, 'JPG', top_left_margin, -(PDF_Height*i)+(top_left_margin*4),canvas_image_width,canvas_image_height);
			}
		    pdf.save("stats.pdf");
        });	
});
</script> 

</body>
</html>
