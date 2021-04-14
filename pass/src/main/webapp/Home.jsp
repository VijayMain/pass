<!DOCTYPE html>
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
  <title>Summary Reports</title> 
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
	/* background-color: #dedede; */
}

table.gridtable td {
font-size: 10px;
	border-width: 1px;
	padding: 2px;
	border-style: solid;
	border-color: #666666;
	background-color: #ffffff;
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
	
	String toDate ="";
	String fromDate ="", datafor="all";
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
		datafor = request.getParameter("datafor");
		flag=true;
	}
/*-------------------------------------------------------------------------------------------------------------------*/
/*-------------------------------------------------------------------------------------------------------------------*/ 
%>  
<!---------------------------------------------------------------  Include Header ---------------------------------------------------------------------------------------->
<%@include file="Header.jsp" %>
<!---------------------------------------------------------------  Include Sidebar ---------------------------------------------------------------------------------------->
<%-- <%@include file="Sidebar.jsp" %> --%>
<!----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->	
      <section class="wrapper"> 
	<!-- ********************************************************************************************************************* -->
	<!-- **************************************************** Data Goes Here ************************************************* -->
	<!-- ********************************************************************************************************************* -->
 <form action="GenerateData_Control" method="post">
    <table class="gridtable" width="90%"> 
					<tr style="background-color: #dedede;color: black;"> 
						<th>Date From [mm/dd/yyyy]</th>
						<th>To Date [mm/dd/yyyy]</th>
						<th>Vendor</th> 
						<th>Get Data</th> 
					</tr> 
					<tr>
						<td><input id="dp2" name="fromdate" style="font-weight: bold;color: black;" type="text" value="<%=fromDate %>" size="16" class="form-control"></td>
						<td><input id="dp3" name="todate" style="font-weight: bold;color: black;" type="text" value="<%=toDate %>" size="16" class="form-control"></td>
						<td>
							<select id="datafor" name="datafor" style="font-weight: bold;color: black;" class="form-control"> 
							<% 
							if(!datafor.equalsIgnoreCase("all")){
							String query = "SELECT  id,site_name FROM Baker_site where enable=1 and id =" + datafor +
									" union all SELECT  id,site_name  FROM Baker_site where enable=1 and id !=" + datafor;
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
							%>
						</select>
       					</td> 
						<td><button class="form-control" style="background-color: #586efc;color: white;"><strong>Generate Data</strong> </button></td> 
					</tr>
    </table>
    </form> 
    <%
    String disp_query = "";
	if(flag==true){	
    %>
   <table id="example" class="stripe row-border order-column" style="width:100%;">
        <thead>
            <tr>
            	<td style="font-weight: bold;color: black;">Part Name</td>
                <%
				PreparedStatement ps_head = conMaster.prepareStatement("SELECT * FROM Baker_HeaderData where enable=1");
				ResultSet rs_head = ps_head.executeQuery();
				while(rs_head.next()){
					if(!rs_head.getString("parameter").equalsIgnoreCase("Serial No") &&
							!rs_head.getString("parameter").equalsIgnoreCase("Batch") &&
								!rs_head.getString("parameter").equalsIgnoreCase("Machine") &&
									!rs_head.getString("parameter").equalsIgnoreCase("Operator")){	
				%>
				<td style="font-weight: bold;color: black;"><%=rs_head.getString("parameter") %> 
				<%
					}
				if(!rs_head.getString("range_from").equalsIgnoreCase("")){
				%>
				<br/>
				[<%=rs_head.getString("range_from") %>/<%=rs_head.getString("range_to") %>]  <%} %></td> 
				<%
				}
				%>
				<td style="font-weight: bold;color: black;">Vendor Name</td> 
			</tr>
        </thead>
        <tbody>
            	<%
            	String vendor="",db_site="";
            	ArrayList multVendor = new ArrayList(); 
            	if(!datafor.equalsIgnoreCase("all")){
            		
            		ps_vendor = conMaster.prepareStatement("select * from Baker_site_rel where enable=1 and vendor_id="+Integer.valueOf(datafor));
					rs_vendor = ps_vendor.executeQuery();
					while (rs_vendor.next()) {
						multVendor.add(rs_vendor.getString("db_name"));
					}
					for(int i=0;i<multVendor.size();i++){
						if(i==0){
							disp_query = "select * from "+multVendor.get(i).toString()+" where enable=1 and CAST(datetime_sheet as date) between '"+fromDate+"' and '"+toDate+"'";
						}else{
							disp_query = disp_query + " union all select * from "+multVendor.get(i).toString()+" where enable=1 and CAST(datetime_sheet as date) between '"+fromDate+"' and '"+toDate+"'";
						}
					}
					
            	}else{
            		
            		ps_vendor = conMaster.prepareStatement("select * from Baker_site_rel where enable=1");
					rs_vendor = ps_vendor.executeQuery();
					while (rs_vendor.next()) {
						multVendor.add(rs_vendor.getString("db_name"));
					}
					for(int i=0;i<multVendor.size();i++){
						if(i==0){
							disp_query = "select * from "+multVendor.get(i).toString()+" where enable=1 and CAST(datetime_sheet as date) between '"+fromDate+"' and '"+toDate+"'";
						}else{
							disp_query = disp_query + " union all select * from "+multVendor.get(i).toString()+" where enable=1 and CAST(datetime_sheet as date) between '"+fromDate+"' and '"+toDate+"'";
						}
					}
            	}
            	 
            	PreparedStatement ps_summary = conMaster.prepareStatement(disp_query);
						ResultSet rs_summary = ps_summary.executeQuery();
						while (rs_summary.next()) {
				%>
					<tr style="color: black;">
								<td><%=rs_summary.getString("part_name")%></td>
					<%-- <td><%=rs_summary.getString("serial_no")%></td> --%>
								<td><%= formatDate.format(rs_summary.getTimestamp("datetime_sheet")) %>	</td>
					<%-- <td><%=rs_summary.getString("batch")%></td>
								<td><%=rs_summary.getString("machine")%></td>
								<td><%=rs_summary.getString("operator")%></td> --%>
								<td><%=rs_summary.getString("top_id")%></td>
								<td><%=rs_summary.getString("bot_id")%></td>
								<td><%=rs_summary.getString("top_oval")%></td>
								<td><%=rs_summary.getString("bot_oval")%></td>
								<td><%=rs_summary.getString("taper")%></td>
								<td><%=rs_summary.getString("od")%></td>
								<td><%=rs_summary.getString("mh_ht")%></td>
								<td><%=rs_summary.getString("parality")%></td>
								<td><%=rs_summary.getString("th_ht")%></td>
								<td>
								<%
								if(rs_summary.getString("result").equalsIgnoreCase("ACCEPT")){
								%>
								<strong style="background-color: green;color: white;"><%=rs_summary.getString("result")%></strong>   
								<%
								}else{
								%>
								<strong style="background-color: red;color: white;"><%=rs_summary.getString("result")%></strong>   
								<%	
								}
								%>
								</td>  
								<td><%=rs_summary.getString("vendor_name")%></td>
							</tr>
							<%
								} 
            	/* else{
            		disp_query = "select * from baker_vendor_summary where enable=1 and CAST(datetime_sheet as date) between DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0) and GETDATE()";	
            	} */
				%>
        </tbody>
    </table>   
    <%
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
