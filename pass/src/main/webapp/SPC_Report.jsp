<!DOCTYPE html>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Collections"%>
<%@page import="com.muthagroup.dao.SPC_DataDAO"%>
<%@page import="java.text.Format"%>
<%@page import="com.muthagroup.conUtil.Connection_Util"%>
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
  <title>SPC Reports</title> 
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
<script src="js/freeze/jquery-3.5.1.js"></script>
   <script src="js/freeze/dataTables.fixedColumns.min.js"></script>
    <script src="js/freeze/jquery.dataTables.min.js"></script>
  <link href="js/freeze/fixedColumns.dataTables.min.css" rel="stylesheet">
  <link href="js/freeze/jquery.dataTables.min.css" rel="stylesheet">
  <style type="text/css">
  th, td { white-space: nowrap; }
    div.dataTables_wrapper {
        width: 100%;
        height:550px;
        margin: 0 auto;
    }
    
    
    table.gridtable {
	font-family: verdana, arial, sans-serif; 
	color: black;
	border-width: 1px;
	border-color: #666666;
	border-collapse: collapse;
}

table.gridtable th {
	font-size: 11px;
	border-width: 1px;
	padding: 4px;
	border-style: solid;
	border-color: #666666;
	text-align: center;
	color: black;
	background-color: #dedede;
}

table.gridtable td {
font-size: 10px;
	border-width: 1px;
	padding: 2px;
	border-style: solid;
	border-color: #666666;
	background-color: #ffffff;
	text-align: right;
} 
  </style>
  <script type="text/javascript">
  $(document).ready(function() {
	    var table = $('#example').DataTable( {
	        scrollY:        "320px",
	        scrollX:        true,
	        scrollCollapse: true,
	        paging:         false,
	        fixedColumns:   {
	            leftColumns: 1,
	            rightColumns: 1
	        }
	    } );
	} );
  </script>
  <link href="css/style.css" rel="stylesheet">
  <link href="css/style-responsive.css" rel="stylesheet" />  
  <!--  Graph  -->
<script type="text/javascript" src="js/loader.js"></script>
</head> 
<body>
<%
try{
	int newCount=0, openCount=0, reOpenCount=0, closedCount=0;
	Connection con = Connection_Util.getLocalUserConnection(); 
	Connection conMaster = Connection_Util.getConnectionMaster();
	PreparedStatement ps_check = null, ps_check1=null, ps_vendor = null; 
	ResultSet rs_check = null,rs_check1=null,rs_vendor=null;   
	SimpleDateFormat formatDate = new SimpleDateFormat("dd/MM/yyyy hh:mm a");
	DecimalFormat df = new DecimalFormat("00.0000");
	DecimalFormat df5 = new DecimalFormat("00.00000");
	String toDate ="";
	String fromDate ="";
	boolean flag=false;
	if(request.getParameter("fromDate")==null){
	Date date = new Date();
	toDate = new SimpleDateFormat("MM/dd/yyyy").format(date); 
	Calendar c = Calendar.getInstance();
	c.set(Calendar.DAY_OF_MONTH, 1);
	fromDate = new SimpleDateFormat("MM/dd/yyyy").format(c.getTime());
	}else{
		toDate =request.getParameter("toDate");
		fromDate =request.getParameter("fromDate"); 
		flag=true;
	} 
	ArrayList xLarge = new ArrayList();
	ArrayList xSmall = new ArrayList();
	ArrayList xAvg = new ArrayList();
	ArrayList xRange = new ArrayList();
	ArrayList parameter = new ArrayList(); 
	ArrayList row1 = new ArrayList(); 
	ArrayList row2 = new ArrayList(); 
	ArrayList row3 = new ArrayList(); 
	ArrayList row4 = new ArrayList(); 
	ArrayList row5 = new ArrayList(); 
	ArrayList date_pass = new ArrayList();  
	ArrayList datafor = new ArrayList(); 
	
	boolean flagView=false;
	
	if (request.getAttribute("xLarge") != null  && request.getAttribute("xSmall") != null && 
		request.getAttribute("xAvg") != null && request.getAttribute("xRange") != null) {
		xLarge = (ArrayList) request.getAttribute("xLarge");
		xSmall = (ArrayList) request.getAttribute("xSmall");
		xAvg = (ArrayList) request.getAttribute("xAvg");
		xRange = (ArrayList) request.getAttribute("xRange");
		parameter = (ArrayList) request.getAttribute("parameter");
		row1 = (ArrayList) request.getAttribute("row1");
		row2 = (ArrayList) request.getAttribute("row2");
		row3 = (ArrayList) request.getAttribute("row3");
		row4 = (ArrayList) request.getAttribute("row4");
		row5 = (ArrayList) request.getAttribute("row5");
		date_pass = (ArrayList) request.getAttribute("date_pass");	
		datafor = (ArrayList) request.getAttribute("datafor");
		
		fromDate = date_pass.get(0).toString();   
		toDate = date_pass.get(1).toString();
		
		flagView=true;
		//System.out.println("There are values in the arraylist" + xLarge + " = " + xSmall + " =" + xAvg + " = " + xRange + " = " + parameter + " = " + datafor);
	} else {
		//System.out.println("There are no values in the arraylist");
	}
/*-------------------------------------------------------------------------------------------------------------------*/
/*-------------------------------------------------------------------------------------------------------------------*/ 
%>  
<!---------------------------------------------------------------  Include Header ---------------------------------------------------------------------------------------->
<%@include file="Header.jsp" %>
<!---------------------------------------------------------------  Include Sidebar ---------------------------------------------------------------------------------------->
<%-- <%@include file="Sidebar.jsp" %> --%>
<!----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->	
      <section class="wrapper" style="background-color: white;"> 
	<!-- ********************************************************************************************************************* -->
	<!-- **************************************************** Data Goes Here ************************************************* -->
	<!-- ********************************************************************************************************************* -->
 <form action="SPCData_Control" method="post">
    <table class="gridtable" width="100%">
					<tr style="background-color: #dedede;color: black;"> 
						<th>Date From [mm/dd/yyyy]</th>
						<th>To Date [mm/dd/yyyy]</th>
						<th>Vendor</th>
						<th>Parameter</th> 
						<th>Get Data</th> 
					</tr> 
					<tr>
						<td><input id="dp2" name="fromdate" style="font-weight: bold;color: black;" type="text" value="<%=fromDate %>" size="16" class="form-control"></td>
						<td><input id="dp3" name="todate" style="font-weight: bold;color: black;" type="text" value="<%=toDate %>" size="16" class="form-control"></td>
						<td>
							<select id="datafor" name="datafor" style="font-weight: bold;color: black;" class="form-control"> 
							<% 
							if(datafor.size()>0){
							if(!datafor.get(0).toString().equalsIgnoreCase("all")){
							String query = "SELECT  id,site_name FROM Baker_site where enable=1 and id =" + Integer.valueOf(datafor.get(0).toString()) +
									" union all SELECT  id,site_name  FROM Baker_site where enable=1 and id !=" + Integer.valueOf(datafor.get(0).toString());
							ps_vendor = conMaster.prepareStatement(query);
							rs_vendor = ps_vendor.executeQuery();
							while (rs_vendor.next()) {
							%>
							<option value="<%=rs_vendor.getInt("id")%>"><%=rs_vendor.getString("site_name")%></option>
							<%
							}
							%>
							<option value="all">- - - - - ALL Vendors - - - - -</option>
							<%
							}else{
							%>
							<option value="all">- - - - - ALL Vendors - - - - -</option>
							<%
							String query = "SELECT  id,site_name  FROM Baker_site where enable=1";
							ps_vendor = conMaster.prepareStatement(query);
							rs_vendor = ps_vendor.executeQuery();
							while (rs_vendor.next()) {
							%>
							<option value="<%=rs_vendor.getInt("id")%>"><%=rs_vendor.getString("site_name")%></option>
							<%
								}
							}
							}else{
							%>
							<option value="all">- - - - - ALL Vendors - - - - -</option>
							<%
							String query = "SELECT  id,site_name  FROM Baker_site where enable=1";
							ps_vendor = conMaster.prepareStatement(query);
							rs_vendor = ps_vendor.executeQuery();
							while (rs_vendor.next()) {
							%>
							<option value="<%=rs_vendor.getInt("id")%>"><%=rs_vendor.getString("site_name")%></option>
							<%
								}
							}		
							%>
						</select>
       					</td> 
       					
       					
       					<td>
					<select id="parameter" name="parameter" style="font-weight: bold;color: black;" class="form-control">
						<%
								String query ="";
								if(flagView==true){
									query = "SELECT *  FROM Baker_HeaderData where id="+Integer.valueOf(parameter.get(3).toString());
									PreparedStatement ps_header = conMaster.prepareStatement(query);
									ResultSet rs_header = ps_header.executeQuery();
									while (rs_header.next()) {
						%>
						<option value="<%=rs_header.getInt("id")%>"><%=rs_header.getString("parameter")%> <%=rs_header.getString("range_from")%> - <%=rs_header.getString("range_to")%></option>
						<%
							} 
								}
								query = "SELECT * FROM Baker_HeaderData where range_from!='' and range_to!=''";
											PreparedStatement ps_header = conMaster.prepareStatement(query);
											ResultSet rs_header = ps_header.executeQuery();
											while (rs_header.next()) {
								%>
								<option value="<%=rs_header.getInt("id")%>"><%=rs_header.getString("parameter")%> <%=rs_header.getString("range_from")%> - <%=rs_header.getString("range_to")%></option>
								<%
									}
								%>
						</select></td>
       					
       					
						<td><button class="form-control" style="background-color: #586efc;color: white;"><strong>Generate SPC Data</strong> </button></td> 
					</tr>
    </table>
    </form>
    
<%
if(flagView==true){
	int snNo=1; 
		String viewVendor=datafor.get(0).toString();
		if(!datafor.get(0).toString().equalsIgnoreCase("all")){
		PreparedStatement ps_datafor = conMaster.prepareStatement("select site_name from Baker_site where id="+ Integer.valueOf(datafor.get(0).toString()));
		ResultSet rs_datafor = ps_datafor.executeQuery();
		while(rs_datafor.next()){
			viewVendor = rs_datafor.getString("site_name");
		}
		}
		//System.out.println("Data For = = = " + datafor.get(0).toString());
%>
<div style="width: 50%;float: left;font-size: 12px;">
<table class="gridtable" width="100%">
<tr style="font-weight: bold;color: black;">
						<th colspan="4"><strong style="font-size: 13px;"><%=parameter.get(0).toString() %></strong> <strong style="font-size: 13px;">[ <%=parameter.get(1).toString() %> - <%=parameter.get(2).toString() %> ]</strong></th>
						<th colspan="4" align="left"><strong style="font-size: 13px;"><%=viewVendor %></strong> </th>
						<th colspan="3" align="left"><strong style="font-size: 13px;">No of Readings : 50</strong> </th> 
					</tr>
					<tr>
						<th>S.No</th>
						<th>1</th>
						<th>2</th>
						<th>3</th>
						<th>4</th>
						<th>5</th>
						<th>6</th>
						<th>7</th>
						<th>8</th>
						<th>9</th>
						<th>10</th>
					</tr>
					<tr>
					<th><b><%=snNo %></b></th>
					<%
					for(int i=0;i<row1.size();i++){
					%>					
					<td><%=row1.get(i).toString() %></td>				
					<%
					}
					snNo++;
					%>
					</tr> 
					<tr>
					<th><b><%=snNo %></b></th>
					<%
					for(int i=0;i<row2.size();i++){
					%>					
					<td><%=row2.get(i).toString() %></td>					
					<%
					}
					snNo++;
					%>
					</tr>
					<tr>
					<th><b><%=snNo %></b></th>
					<%
					for(int i=0;i<row3.size();i++){
					%>					
					<td><%=row3.get(i).toString() %></td>					
					<%
					}
					snNo++;
					%>
					</tr>
					<tr>
					<th><b><%=snNo %></b></th>
					<%
					for(int i=0;i<row4.size();i++){
					%>					
					<td><%=row4.get(i).toString() %></td>					
					<%
					}
					snNo++;
					%>
					</tr>
					<tr>
					<th><b><%=snNo %></b></th>
					<%
					for(int i=0;i<row5.size();i++){
					%>					
					<td><%=row5.get(i).toString() %></td>					
					<%
					}
					snNo++;
					%>
					</tr>
					
					<tr>
					<th align="left"><!-- X Large -->Max</th>
					<%
					for(int i=0;i<xLarge.size();i++){
					%>					
					<td style="background-color: #e3f0ff"><%=xLarge.get(i).toString() %></td>					
					<%
					}
					snNo++;
					%>
					</tr>
					
					<tr>
					<th align="left"><!-- X Small -->Min</th>
					<%
					for(int i=0;i<xSmall.size();i++){
					%>					
					<td style="background-color: #e3f0ff"><%=xSmall.get(i).toString() %></td>					
					<%
					}
					snNo++;
					%>
					</tr>
					
					<tr>
					<th align="left">Range</th>
					<%
					for(int i=0;i<xRange.size();i++){
					%>					
					<td style="background-color: #e3f0ff"><%=xRange.get(i).toString() %></td>					
					<%
					}
					snNo++;
					%>
					</tr>
					
					<tr>
					<th align="left">AVG</th>
					<%
					for(int i=0;i<xAvg.size();i++){
					%>					
					<td style="background-color: #e3f0ff"><%=xAvg.get(i).toString() %></td>					
					<%
					}
					snNo++;
					%>
					</tr> 		
</table>					
</div>
<div style="width: 49.5%; float: right;font-size: 12px;">
<%
double sampleValuea2=0.0,sampleValued4=0.0;
PreparedStatement ps_sample = conMaster.prepareStatement("SELECT a2,d4  FROM baker_sample where id = 5 and enable=1");
ResultSet rs_sample = ps_sample.executeQuery();
while(rs_sample.next()){
	sampleValuea2 = Double.valueOf(rs_sample.getString("a2"));
	sampleValued4 = Double.valueOf(rs_sample.getString("d4"));
}
 

ArrayList xMax = new ArrayList();
ArrayList xMin = new ArrayList();
Double xBar = 0.0; 
Double rBar = 0.0; 
Double ucl_xBar=0.0, lcl_xBar=0.0;
Double ucl_rBar=0.0, lcl_rBar=0.0;
Double xbalValue = 0.0, rRangeval=0.0;
Double std_dev=0.0;
ArrayList alldata=new ArrayList();

xMax.add(Collections.max(xLarge));
xMin.add(Collections.max(xSmall));

for(int i=0;i<10;i++){
	xbalValue = xbalValue + (Double.parseDouble(row1.get(i).toString()) + Double.parseDouble(row2.get(i).toString()) 
			+ Double.parseDouble(row3.get(i).toString()) + Double.parseDouble(row4.get(i).toString())
			+ Double.parseDouble(row5.get(i).toString()));
	alldata.add(xbalValue);
}
xBar =Double.valueOf(df.format(xbalValue/50));
Double xaverage =0.0;

for(int i=0;i<10;i++){
	rRangeval = rRangeval + Double.parseDouble(xRange.get(i).toString());
	xaverage = xaverage + Double.parseDouble(xAvg.get(i).toString());
}
xaverage =  Double.valueOf(df.format(xaverage/10));

rBar = Double.valueOf(df.format(rRangeval/10));

ucl_xBar = Double.valueOf(df.format(xBar + (sampleValuea2*rBar)));
lcl_xBar = Double.valueOf(df.format(xBar- (sampleValuea2*rBar)));
ucl_rBar = Double.valueOf(df.format(rBar*sampleValued4));
lcl_rBar = Double.valueOf(df.format(rBar*0));

 Double sumstdDev = xbalValue/50,sumDevcheck=0.0;
 for(int i=0;i<10;i++){
	 sumDevcheck = sumDevcheck + (Math.pow((Double.parseDouble(row1.get(i).toString())-sumstdDev),2) + Math.pow((Double.parseDouble(row2.get(i).toString())-sumstdDev),2)
				+ Math.pow((Double.parseDouble(row3.get(i).toString())-sumstdDev),2) + Math.pow((Double.parseDouble(row4.get(i).toString())-sumstdDev),2)
				+ Math.pow((Double.parseDouble(row5.get(i).toString())-sumstdDev),2));		
	}
 
 Double range2 =Double.valueOf(parameter.get(2).toString());
 Double range1 =Double.valueOf(parameter.get(1).toString()); 
 Double tolerance = range2 - range1;
 
 sumDevcheck = sumDevcheck/50;
 Double stdDev = Double.valueOf(df.format(Math.sqrt(sumDevcheck)));
 Double specWidth= Math.abs(Double.valueOf(df5.format(tolerance)));
 
/*  Double cp = Double.valueOf(df.format((6*stdDev)/tolerance)); */

Double cp = Double.valueOf(df.format(specWidth/(stdDev*6)));

Double designCenter =(range1+range2)/2;
Double shiftXbar = Math.abs(xBar-designCenter);
Double indexK=(2*shiftXbar)/specWidth;
Double avgLsl=0.0;		
 //Double cpk =Double.valueOf(df.format( (1-indexK)*cp));  xaverage  
 //System.out.println("std dev = " + stdDev + " avg =  " + xaverage); 

 /* Double cpk_uSL = Double.valueOf(df.format((3*stdDev)/(range2-xaverage))); */
 Double cpk_uSL = Double.valueOf(df.format(((1-indexK)*cp)));
 
 // System.out.println(cp + "cpk_uSL = " + cpk_uSL+" = " + specWidth + " = " + tolerance + " = " + shiftXbar); 
 %>
<table class="gridtable" width="100%">
<tr style="font-weight: bold;color: black;">
<th colspan="6"><strong style="font-size: 15px;">SPC Details</strong></th>
</tr> 
<tr>
<th>X Max </td>
<th>X Min</th>
<th><!-- R Bar -->R-Chart</th>
<th><!-- X Bar -->X-Chart</th>
<th>U.C.L. X BAR</th>
<th>U.C.L. R BAR</th>
</tr>
<tr align="right">
<td><strong><%=xMax.get(0).toString() %></strong></td>
<td><strong><%=xMin.get(0).toString() %></strong></td>
<td><strong><%=rBar %></strong></td>
<td><strong><%=xBar %></strong></td>
<td><strong><%=ucl_xBar %></strong></td>
<td><strong><%=ucl_rBar %></strong></td>
</tr>
<tr>
<th>L.C.L. X BAR </th>
<th>L.C.L. R BAR </th>
<th>Std.Dev.</th>
<th>Specification Width(S)</th>
<th>Cp</th>
<th>Cpk</th>
</tr>
<tr align="right">
<td><strong><%=lcl_xBar %></strong></td>
<td><strong><%=lcl_rBar %></strong></td>
<td><strong><%=df5.format(stdDev) %></strong></td> 
<td><strong><%=specWidth %></strong></td>
<td><strong><%=cp %></strong></td>
<td><strong><%=cpk_uSL%></strong></td>
</tr>
</table>   

</div> 
<script> 
	
	google.charts.load('current', {'packages':['line']});
    google.charts.setOnLoadCallback(drawChart);
    google.charts.setOnLoadCallback(drawChart1);
	
	
	function drawChart() {
	  var data= google.visualization.arrayToDataTable(
	    [['X - Chart', 'AVG','U.C.L.','L.C.L.','X-Chart'], 
	    	<%
	    	for(int i=0;i<10;i++){
	    	%>
	    	[<%=i+1%>,  <%= Double.valueOf(xAvg.get(i).toString())%> ,  <%=ucl_xBar%> , <%=lcl_xBar%> , <%=xBar%> ],
	    	<%
	    	}
	    	%> 
	    ]);
 
	  // format numbers in second column to 5 decimals
	  var formatter = new google.visualization.NumberFormat({
	    pattern: '#,##0.0000'
	  });
	  formatter.format(data, 1); 
	  var options1 = {
			  title: 'Graph For X-Chart',

			  width: 600,
		        height: 350, 
	    axes: {
	      x: {
	        0: {side: 'down'}
	      }
	    },
	    vAxis: {format: '#,##0.0000'}
	  }; 
 
	  var chart1 = new google.charts.Line(document.getElementById('x_chart')); 
	  chart1.draw(data, google.charts.Line.convertOptions(options1)); 
	   
	} 
	
	
	
	
	function drawChart1() {
		  var data1= google.visualization.arrayToDataTable(
		    [['R - Chart', 'Range','U.C.L.','L.C.L.','R-Chart'], 
		    	<%
		    	for(int i=0;i<10;i++){
		    	%>
		    	[<%=i+1%>,  <%= Double.valueOf(xRange.get(i).toString())%> ,  <%=ucl_rBar%> , <%=lcl_rBar%> , <%=rBar%> ],
		    	<%
		    	}
		    	%> 
		    ]);
	 
		  // format numbers in second column to 5 decimals
		  var formatter1 = new google.visualization.NumberFormat({
		    pattern: '#,##0.0000'
		  });
		  formatter1.format(data1, 1); 
		  var options2 = {
				  title: 'Graph for R-Chart',
				  width: 600,
			        height: 350, 
		    axes: {
		      x: {
		        0: {side: 'down'}
		      }
		    },
		    vAxis: {format: '#,##0.0000'}
		  }; 
	 
		  var chart1 = new google.charts.Line(document.getElementById('r_chart')); 
		  chart1.draw(data1, google.charts.Line.convertOptions(options2)); 
		   
		}  
</script>  
<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
<div id="x_chart" style="width: 49.8%;float: left;font-size: 12px;"></div>
  <div id="r_chart" style="width: 49.8%;float: left;font-size: 12px;"></div>

<%
lcl_xBar=0.0;   lcl_rBar=0.0;   specWidth=0.0;   cp=0.0;   cpk_uSL=0.0; 
}
%>
    
    
    
    </section>
    <%
	}catch(Exception e){
		e.printStackTrace();
	}
    %> 
  <!-- container section end -->
  <!-- javascripts --> 
  <script src="js/bootstrap.min.js"></script> 
  <!-- jquery ui -->
  <script src="js/jquery-ui-1.9.2.custom.min.js"></script> 
  <!--custom checkbox & radio-->
  <script type="text/javascript" src="js/ga.js"></script>
  <!--custom switch-->
  <script src="js/bootstrap-switch.js"></script> 
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
 <script src="js/jquery.hotkeys.js"></script>
<script src="js/jquery.hotkeys.js"></script>
  <script src="js/bootstrap-wysiwyg.js"></script>
  <script src="js/bootstrap-wysiwyg-custom.js"></script>
</body>

</html>
