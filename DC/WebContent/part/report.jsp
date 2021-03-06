<%@page import="com.bitmap.utils.ReportUtils"%>
<%@page import="com.bitmap.webutils.customtag.ComboBoxTag"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.bitmap.webutils.PageControl"%>
<%@page import="com.bitmap.security.SecurityUnit"%>
<%@page import="com.bitmap.security.SecuritySystem"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.bitmap.webutils.WebUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<script src="../js/jquery.min.js"></script>
<script src="../js/jquery.validate.js"></script>
<script src="../js/jquery.metadata.js"></script>
<script src="../js/thickbox.js"></script>
<script src="../js/loading.js"></script>
<script src="../js/popup.js"></script>

<link href="../themes/vbi-theme/jquery.ui.all.css" rel="stylesheet" type="text/css">

<script src="../js/ui/jquery.ui.core.js"></script>
<script src="../js/ui/jquery.ui.widget.js"></script>
<script src="../js/ui/jquery.ui.datepicker.js"></script>

<link href="../css/style.css" rel="stylesheet" type="text/css" media="all">
<link href="../css/unit.css" rel="stylesheet" type="text/css" media="all">
<link href="../css/loading.css" rel="stylesheet" type="text/css" media="all">
<link href="../css/table.css" rel="stylesheet" type="text/css" media="all">

<%@ taglib uri="/WEB-INF/lib/customtag.tld" prefix="bmp" %>
<jsp:useBean id="securProfile" class="com.bitmap.security.SecurityProfile" scope="session"></jsp:useBean>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Report</title>
<script type="text/javascript">
 
$(function(){
	$( "#date" ).datepicker({
		showOtherMonths: true,
		selectOtherMonths: true,
		changeMonth: true
	});
	$( "#date1" ).datepicker({
		showOtherMonths: true,
		selectOtherMonths: true,
		changeMonth: true
	});
	$( "#date2" ).datepicker({
		showOtherMonths: true,
		selectOtherMonths: true,
		changeMonth: true
	});

	var form = $('#report_form');
	var tr_type_time = $('#tr_type_time');
	var tr_date = $('#tr_date');
	var tr_month = $('#tr_month');
	var tr_matcode = $('#tr_matcode');
	var tr_date_date = $('#tr_date_date');
	
	
	$('#btn_view').click(function(){
				
	if(document.getElementById("report_type").value != "1"){
			
			if (document.getElementById("report_type").value == "part_stock"  || document.getElementById("report_type").value == "part_stock_branch" || document.getElementById("report_type").value == "part_mor"){
				
				popup('report_review.jsp?' + form.serialize());
			}else{
				if (document.getElementById("type_date").checked || document.getElementById("type_month").checked ||  document.getElementById("type_date_date").checked == true) {
					
					 var date = $('#date').val();
					 var date1 = $('#date1').val();
					 var date2 = $('#date2').val();
					 
						 		if (document.getElementById("type_date").checked == true){
						 			if(date == ""){
										
										alert("คุณยังไม่ได้ระบุวันที่ต้องการดูรายงาน");
										$('#date').focus();
									}else{
										var dd = document.getElementById("date").value;
										var str = dd.split("/");
										var date_farmat_str = str[2]+"-"+str[1]+"-"+str[0];
										document.getElementById("create_date").value = date_farmat_str; 
										popup('report_review.jsp?' + form.serialize());
									} 	
								}else if (document.getElementById("type_month").checked == true){ 
										var mm = document.getElementById("month").value;
										var yy = document.getElementById("year").value;
										
										if(mm < 10){
											var ymd = yy+"-"+"0"+mm; 
											document.getElementById("year_month").value = ymd;
										}else{ 
											var ymd = yy+"-"+mm; 
											document.getElementById("year_month").value = ymd;
										}
										popup('report_review.jsp?' + form.serialize());
								}else if (document.getElementById("type_date_date").checked == true){
											if(date1 && date2  == ""){
												alert("คุณยังไม่ได้ระบุวันที่ต้องการดูรายงาน");
												$('#date2').focus();
											} else{
												if(date1 == ""){
													alert("คุณยังไม่ได้ระบุวันที่ต้องการดูรายงาน");
													$('#date1').focus();
												}
												else if(date2 == ""){
													alert("คุณยังไม่ได้ระบุวันที่ต้องการดูรายงาน");
													$('#date2').focus();
												}else{
													
													var dd1 = document.getElementById("date1").value;
													var str1 = dd1.split("/");
													var date_farmat_str1 = str1[2]+"-"+str1[1]+"-"+str1[0];
													document.getElementById("date_send2").value = date_farmat_str1;
													
													
													var dd2 = document.getElementById("date2").value;
													var str2 = dd2.split("/");
													var date_farmat_str2 = str2[2]+"-"+str2[1]+"-"+str2[0];
													document.getElementById("date_send3").value = date_farmat_str2;
													popup('report_review.jsp?' + form.serialize());
													
												}
											} 
								}
									
								
									
				}else{
					var No_time = "0";
					data =  "rd_time="+No_time;	
					popup('report_review.jsp?&'+data+'&'+form.serialize());
					//alert("คุณยังไม่ได้ระบุวันที่ต้องการดูรายงาน");
										
				} 
			}//	
		}else{
			alert("กรุณาเลือกประเภทรายงาน");
		}	
			
	
	});
	
	$('#btn_export').click(function(){
				
	if(document.getElementById("report_type").value != "1"){
			
			if (document.getElementById("report_type").value == "part_stock"  || document.getElementById("report_type").value == "part_stock_branch" || document.getElementById("report_type").value == "part_mor"){
				
				popup('report_review.jsp?export=true&' + form.serialize());
			}else{
				if (document.getElementById("type_date").checked || document.getElementById("type_month").checked ||  document.getElementById("type_date_date").checked == true) {
					
					 var date = $('#date').val();
					 var date1 = $('#date1').val();
					 var date2 = $('#date2').val();
					 
						 		if (document.getElementById("type_date").checked == true){
						 			if(date == ""){
										
										alert("คุณยังไม่ได้ระบุวันที่ต้องการดูรายงาน");
										$('#date').focus();
									}else{
										var dd = document.getElementById("date").value;
										var str = dd.split("/");
										var date_farmat_str = str[2]+"-"+str[1]+"-"+str[0];
										document.getElementById("create_date").value = date_farmat_str; 
										popup('report_review.jsp?export=true&' + form.serialize());
									} 	
								}else if (document.getElementById("type_month").checked == true){ 
										var mm = document.getElementById("month").value;
										var yy = document.getElementById("year").value;
										
										if(mm < 10){
											var ymd = yy+"-"+"0"+mm; 
											document.getElementById("year_month").value = ymd;
										}else{ 
											var ymd = yy+"-"+mm; 
											document.getElementById("year_month").value = ymd;
										}
										popup('report_review.jsp?export=true&' + form.serialize());
								}else if (document.getElementById("type_date_date").checked == true){
											if(date1 && date2  == ""){
												alert("คุณยังไม่ได้ระบุวันที่ต้องการดูรายงาน");
												$('#date2').focus();
											} else{
												if(date1 == ""){
													alert("คุณยังไม่ได้ระบุวันที่ต้องการดูรายงาน");
													$('#date1').focus();
												}
												else if(date2 == ""){
													alert("คุณยังไม่ได้ระบุวันที่ต้องการดูรายงาน");
													$('#date2').focus();
												}else{
													
													var dd1 = document.getElementById("date1").value;
													var str1 = dd1.split("/");
													var date_farmat_str1 = str1[2]+"-"+str1[1]+"-"+str1[0];
													document.getElementById("date_send2").value = date_farmat_str1;
													
													
													var dd2 = document.getElementById("date2").value;
													var str2 = dd2.split("/");
													var date_farmat_str2 = str2[2]+"-"+str2[1]+"-"+str2[0];
													document.getElementById("date_send3").value = date_farmat_str2;
													popup('report_review.jsp?export=true&' + form.serialize());
													
												}
											} 
								}
									
								
									
				}else{
					
					var No_time = "0";
					data =  "rd_time="+No_time;										
					popup('report_review.jsp?export=true&'+data+'&'+ form.serialize());
					//alert("คุณยังไม่ได้ระบุวันที่ต้องการดูรายงาน");
										
				} 
			}//	
		}else{
			alert("กรุณาเลือกประเภทรายงาน");
		}	
	});
	
	$('#report_type').change(function(){
		// aon create 19-02-2014
		
		$("#pn").val("");
		$("input:radio").removeAttr("checked");
		$('#report_form input[type="text"]').val("");
		
		//end aon create 19-02-2014
		
		
		if ($(this).val() == "1" || $(this).val() == "<%=ReportUtils.PART_STOCK%>"  || $(this).val() == "<%=ReportUtils.PART_MOR%>" || $(this).val() == "<%=ReportUtils.PART_STOCK_BRANCH%>"){
			
			tr_matcode.hide();
			tr_type_time.hide();
			tr_date.hide();
			tr_month.hide()
			tr_date_date.hide();
		}
		<%--  if ($(this).val() == '<%=ReportUtils.PART_OUT%>' || $(this).val() == '<%=ReportUtils.PART_BOR%>' || $(this).val() == '<%=ReportUtils.PART_ADD%>') {
			
			tr_matcode.show();
			tr_type_time.show();
			$('input:radio[name=time]').removeAttr('checked');
			tr_date.hide();
			tr_month.hide();
		} --%>
		else {
			tr_matcode.show();
			tr_type_time.show();
			$('input:radio[name=time]').removeAttr('checked');
			tr_date.hide();
			tr_month.hide();
		}
	});
	
	$('#type_date').click(function(){
		tr_date.show();
		tr_month.hide();
		tr_date_date.hide();
	});
	
	$('#type_month').click(function(){
		tr_date.hide();
		tr_date_date.hide();
		tr_month.show();
	});
	$('#type_date_date').click(function(){
		tr_date.hide();
		tr_month.hide();
		tr_date_date.show();
		
	});
});
</script>
<style type="text/css">
body table td {padding: 3px 1px;}
</style>
</head>
<body>

<div class="wrap_all">
	<jsp:include page="../index/header.jsp"></jsp:include>
	
	<div class="wrap_body">
		<div class="body_content">
			<div class="content_head">
				Report Parts
			</div>
			
			<div class="content_body">
			<form id="report_form">
			<br />
				<table>
					<tr>
						<td width="30%">ประเภท</td> 
						<td width="68%">:
							<bmp:ComboBox name="report_type" styleClass="txt_box s250" value="">
								<bmp:option value="1"  text="----------------  กรุณาเลือก   ---------------"></bmp:option>
								<bmp:option value="<%=ReportUtils.PART_STOCK%>" text="รายงานสินค้าคงคลัง"></bmp:option>
								<bmp:option value="<%=ReportUtils.PART_STOCK_BRANCH%>" text="รายงานสินค้าคงคลัง(สาขา)"></bmp:option>
								<bmp:option value="<%=ReportUtils.PART_MOR%>" text="รายงานสินค้าเหลือน้อย"></bmp:option>
								<bmp:option value="<%=ReportUtils.PART_OUT%>" text="รายงานการเบิกสินค้า"></bmp:option>
								<bmp:option value="<%=ReportUtils.PART_BOR%>" text="รายงานการยืมสินค้า"></bmp:option>
								 <bmp:option value="<%=ReportUtils.PART_ADD%>" text="รายงานการนำเข้าสินค้า"></bmp:option>
							</bmp:ComboBox>
						</td>
					</tr>
					<tr id="tr_matcode" class="hide">
						<td>รหัสสินค้า</td>
						<td>: 
							 <input type="text" class="txt_box" name="pn" id="pn">
						</td>
					</tr>
					<tr id="tr_type_time" class="hide">
						<td>ช่วงเวลา</td>
						<td>: 
							<input type="radio" name="rd_time" id="type_date" value="1"> <label for="type_date"> ประจำวัน</label> &nbsp;&nbsp;
							<input type="radio" name="rd_time" id="type_month" value="2"> <label for="type_month"> ประจำเดือน</label> <br/>&nbsp;
							<input type="radio" name="rd_time" id="type_date_date" value="3"> <label for="type_date_date">ระหว่างวัน</label>
						</td>
					</tr>
					<tr id="tr_date" class="hide">
						<td>วันที่</td> 
						<td>: <input type="text" class="txt_box" name="create_date1" id="date">
								<input type="hidden" name="create_date" id="create_date" value="">
						</td>
						
					</tr>
					<tr id="tr_date_date" class="hide" >
						<td>ระหว่างวัน</td>
						<td>: <input type="text" class="txt_box" name="date1" id="date1"> &nbsp;ถึงวันที่ &nbsp;
							 	<input type="hidden" name="date_send2" id="date_send2" value="">
							  	<input type="text" class="txt_box" name="date2" id="date2"></td>
								<input type="hidden" name="date_send3" id="date_send3" value="">
					</tr>
					<tr id="tr_month" class="hide">
						<td>เดือน / ปี</td>
						<td>: 
							<bmp:ComboBox name="month" styleClass="txt_box s100" style="<%=ComboBoxTag.EngMonthList%>" value=""></bmp:ComboBox>
							<bmp:ComboBox name="year" styleClass="txt_box s100" style="<%=ComboBoxTag.EngYearList%>" value="null"></bmp:ComboBox>
							<input type="hidden" name="year_month" id="year_month" value="">
						</td>
					</tr>
				</table>
				<br />
				<div class="center txt_center">
					<span class="btn_box btn_confirm" id="btn_view">ดูรายงาน</span>
					<span class="btn_box btn_confirm" id="btn_export">บันทึกเป็นไฟล์</span>
				</div>
			</form>
			</div>
		</div>
	</div>
	<jsp:include page="../index/footer.jsp"></jsp:include>
</div>
</body>
</html>
