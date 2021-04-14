<!DOCTYPE html>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%> 
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<html lang="en"> 
<head> 
  <title>Reports</title> 
  <!-- Bootstrap CSS -->
  <link href="css/bootstrap.min.css" rel="stylesheet">
  <!-- bootstrap theme -->
  <link href="css/bootstrap-theme.css" rel="stylesheet">
  <!--external css-->
  <!-- font icon -->
  <link href="css/elegant-icons-style.css" rel="stylesheet" />
  <link href="css/font-awesome.min.css" rel="stylesheet" />
  <link href="css/daterangepicker.css" rel="stylesheet" />
  <link href="css/bootstrap-datepicker.css" rel="stylesheet" />
  <link href="css/bootstrap-colorpicker.css" rel="stylesheet" />
  <!-- date picker -->
<script type="text/javascript">
    $(".form_datetime").datetimepicker({format: 'yyyy/mm/dd hh:ii'});
     
    function button1(val) {
		var val1 = val; 
		document.getElementById("hid").value = val1;
		edit.submit();
	}
    function ChangeColor(tableRow, highLight) {
		if (highLight) {
			tableRow.style.backgroundColor = '#CFCFCF';
		} else {
			tableRow.style.backgroundColor = '#FFFFFF';
		}
	}
</script>          
<style type="text/css">
table {
  position: relative;
  width: 700px;
  background-color: #aaa;
  overflow: hidden;
  border-collapse: collapse;
}


/*thead*/
thead {
  position: relative;
  display: block; /*seperates the header from the body allowing it to be positioned*/
  width: 700px;
  overflow: visible;
}

thead th {
  background-color: #99a;
  min-width: 120px;
  height: 32px;
  border: 1px solid #222;
}

thead th:nth-child(1) {/*first cell in the header*/
  position: relative;
  display: block; /*seperates the first cell in the header from the header*/
  background-color: #88b;
}


/*tbody*/
tbody {
  position: relative;
  display: block; /*seperates the tbody from the header*/ 
  height: 239px;
  overflow: scroll;
}

tbody td {
  background-color: #bbc;
  min-width: 120px;
  border: 1px solid #222;
}

tbody tr td:nth-child(1) {  /*the first cell in each tr*/
  position: relative;
  display: block; /*seperates the first column from the tbody*/
  height: 40px;
  background-color: #99a;
}

</style>
<script type="text/javascript">
$(document).ready(function() {
	  $('tbody').scroll(function(e) { //detect a scroll event on the tbody
	  	/*
	    Setting the thead left value to the negative valule of tbody.scrollLeft will make it track the movement
	    of the tbody element. Setting an elements left value to that of the tbody.scrollLeft left makes it maintain 			it's relative position at the left of the table.    
	    */
	    $('thead').css("left", -$("tbody").scrollLeft()); //fix the thead relative to the body scrolling
	    $('thead th:nth-child(1)').css("left", $("tbody").scrollLeft()); //fix the first cell of the header
	    $('tbody td:nth-child(1)').css("left", $("tbody").scrollLeft()); //fix the first column of tdbody
	  });
	});

</script>
  <link href="css/style.css" rel="stylesheet">
  <link href="css/style-responsive.css" rel="stylesheet" />  
</head> 
<body>
<%
try{
	int newCount=0, openCount=0, reOpenCount=0, closedCount=0;
	Connection con = Connection_Util.getLocalUserConnection(); 
	PreparedStatement ps_check = null, ps_check1=null;
	ResultSet rs_check = null,rs_check1=null;  
	
	Date date = new Date();
	String toDate = new SimpleDateFormat("MM/dd/yyyy").format(date); 
	
	Calendar c = Calendar.getInstance();
	c.set(Calendar.DAY_OF_MONTH, 1);
	String fromDate = new SimpleDateFormat("MM/dd/yyyy").format(c.getTime()); 
/*-------------------------------------------------------------------------------------------------------------------*/
/*-------------------------------------------------------------------------------------------------------------------*/ 
%> 
<!-- container section start -->
<section id="container" class="">
<!---------------------------------------------------------------  Include Header ---------------------------------------------------------------------------------------->
<%@include file="Header.jsp" %>
<!---------------------------------------------------------------  Include Sidebar ---------------------------------------------------------------------------------------->
<%@include file="Sidebar.jsp" %>
<!----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->	
<!--main content start-->
    <section id="main-content">
      <section class="wrapper">
        <!--overview start-->
       <!--  <div class="row">
          <div class="col-lg-12">
            <h3 class="page-header"><i class="fa fa-laptop"></i> Dashboard</h3>
            <ol class="breadcrumb">
              <li><i class="fa fa-home"></i><a href="Home.jsp">Home</a></li>
              <li><i class="fa fa-laptop"></i>Dashboard  
              </li>
            </ol> 
          </div>
        </div>  -->
	<!-- ********************************************************************************************************************* -->
	<!-- **************************************************** Data Goes Here ************************************************* -->
	<!-- ********************************************************************************************************************* -->
<div class="row" style="height:550px; overflow: scroll;">
          <div class="col-lg-12"> 
              <form action="Generate_ReportControl" method="post">
				
<body>
  <table>
    <thead>
      <tr>
        <th>Name</th>
        <th>Town</th>
        <th>County</th>
        <th>Age</th>
        <th>Profession</th>
        <th>Anual Income</th>
        <th>Matital Status</th>
        <th>Children</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>John Smith</td>
        <td>Macelsfield</td>
        <td>Cheshire</td>
        <td>52</td>
        <td>Brewer</td>
        <td>£47,000</td>
        <td>Married</td>
        <td>2</td>
      </tr>
      <tr>
        <td>Jenny Jones</td>
        <td>Threlkeld</td>
        <td>Cumbria</td>
        <td>34</td>
        <td>Shepherdess</td>
        <td>£28,000</td>
        <td>Single</td>
        <td>0</td>
      </tr>
      <tr>
        <td>Peter Frampton</td>
        <td>Avebury</td>
        <td>Wiltshire</td>
        <td>57</td>
        <td>Musician</td>
        <td>£124,000</td>
        <td>Married</td>
        <td>4</td>
      </tr>
      <tr>
        <td>Simon King</td>
        <td>Malvern</td>
        <td>Worchestershire</td>
        <td>48</td>
        <td>Naturalist</td>
        <td>£65,000</td>
        <td>Married</td>
        <td>2</td>
      </tr>
      <tr>
        <td>Lucy Diamond</td>
        <td>St Albans</td>
        <td>Hertfordshire</td>
        <td>67</td>
        <td>Pharmasist</td>
        <td>Retired</td>
        <td>Married</td>
        <td>3</td>
      </tr>
      <tr>
        <td>Austin Stevenson</td>
        <td>Edinburgh</td>
        <td>Lothian </td>
        <td>36</td>
        <td>Vigilante</td>
        <td>£86,000</td>
        <td>Single</td>
        <td>Unknown</td>
      </tr>
      <tr>
        <td>Wilma Rubble</td>
        <td>Bedford</td>
        <td>Bedfordshire</td>
        <td>43</td>
        <td>Housewife</td>
        <td>N/A</td>
        <td>Married</td>
        <td>1</td>
      </tr>
      <tr>
        <td>Kat Dibble</td>
        <td>Manhattan</td>
        <td>New York</td>
        <td>55</td>
        <td>Policewoman</td>
        <td>$36,000</td>
        <td>Single</td>
        <td>1</td>
      </tr>
      <tr>
        <td>Henry Bolingbroke</td>
        <td>Bolingbroke</td>
        <td>Lincolnshire</td>
        <td>45</td>
        <td>Landowner</td>
        <td>Lots</td>
        <td>Married</td>
        <td>6</td>
      </tr>
      <tr>
        <td>Alan Brisingamen</td>
        <td>Alderley</td>
        <td>Cheshire</td>
        <td>352</td>
        <td>Arcanist</td>
        <td>A pile of gems</td>
        <td>Single</td>
        <td>0</td>
      </tr>
    </tbody>
  </table>
</body>
				 

				</form> 	
              </div>  
          </div>  
      </section> 
    </section>
    
    <%
	}catch(Exception e){
		e.printStackTrace();
	}
    %>
    
     
    <!--main content end-->
  </section>
  <!-- container section end -->
  <!-- javascripts -->
  <script src="js/jquery.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <!-- nice scroll -->
  <script src="js/jquery.scrollTo.min.js"></script>
  <script src="js/jquery.nicescroll.js" type="text/javascript"></script> 
  <!-- jquery ui -->
  <script src="js/jquery-ui-1.9.2.custom.min.js"></script> 
  <!--custom checkbox & radio-->
  <script type="text/javascript" src="js/ga.js"></script>
  <!--custom switch-->
  <script src="js/bootstrap-switch.js"></script>
  <!--custom tagsinput-->
  <script src="js/jquery.tagsinput.js"></script> 
  <!-- colorpicker --> 
  <!-- bootstrap-wysiwyg -->
  <script src="js/jquery.hotkeys.js"></script>
  <script src="js/bootstrap-wysiwyg.js"></script>
  <script src="js/bootstrap-wysiwyg-custom.js"></script>
  <script src="js/moment.js"></script>
  <script src="js/bootstrap-colorpicker.js"></script>
  <script src="js/daterangepicker.js"></script>
  <script src="js/bootstrap-datepicker.js"></script>
  <!-- ck editor -->
  <script type="text/javascript" src="assets/ckeditor/ckeditor.js"></script>
  <!-- custom form component script for this page-->
  <script src="js/form-component.js"></script>
  <!-- custome script for all page -->
  <script src="js/scripts.js"></script>


</body>

</html>
