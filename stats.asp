<%
	Dim dc(5)
	dc(0) = "Test test test?"
	dc(1) =  Array("Reponse 1", "Reponse 2", "Reponse 3")
	dc(2) = Array(203,200,33)
	dc(3) = "Test test test 2?"
	dc(4) =  Array("Reponse 1", "Reponse 2", "Reponse 3")
	dc(5) = Array(201,203,333)
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/0.9.0rc1/jspdf.min.js"></script>
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


	<div class="print" id="print">
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
			plugins: {
			colorschemes: {
				scheme: 'brewer.Paired12'
			}
			}
		}	
		})
		document.write("<hr>");
	}
    </script>
	</div>
<button id="cmd">Download PDF File</button>

<script type="text/javascript">
$(window).on('load', function() {
var doc = new jsPDF();
var specialElementHandlers = {
    '#editor': function (element, renderer) {
        return true;
    }
};
$('#cmd').click(function () {
    doc.fromHTML($('#print').html(), 15, 15, {
        'width': 700,
            'elementHandlers': specialElementHandlers
    });
    doc.save('file.pdf');
});
});
</script> 

</body>
</html>
