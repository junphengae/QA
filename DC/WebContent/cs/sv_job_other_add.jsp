<%@page import="com.bitmap.webutils.WebUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:useBean id="securProfile" class="com.bitmap.security.SecurityProfile" scope="session"></jsp:useBean>

<form id="other_add_form" onsubmit="return false;">
	<div class="m_top10"></div>
	<table width="100%" class="center" id="tb_material_add" border="0" cellpadding="4" cellspacing="4">
		<tbody>
			<tr>
				<td width="25%" align="left">Miscellaneous</td>
				<td width="75%" align="left">: <input type="text" name="other_name" id="other_name" class="txt_box s280 required input_focus" title="*" autocomplete="off"></td>
			</tr>
			<tr>
				<td align="left">Qty</td>
				<td align="left">: <input type="text" name="other_qty" id="other_qty" class="txt_box required" title="*" autocomplete="off"></td>
			</tr>
			<tr>
				<td align="left">Price</td>
				<td align="left">: <input type="text" name="other_price" id="other_price" class="txt_box required" title="*" autocomplete="off"></td>
			</tr>
			<tr>
				<td align="left">Discount</td>
				<td align="left">: <input type="text" name="discount" id="discount" class="txt_box s50" value="0" autocomplete="off"> %</td>
			</tr>
		</tbody>
	</table>
	
	<script type="text/javascript">
	$(function(){
		
		var form = $('#other_add_form');	
		/*material Form*/
		var v = form.validate({
			submitHandler: function(){
				if (isNumber($('#other_price').val())) {
					if (isNumber($('#discount').val())) {
						if (isNumber($('#other_qty').val())) {
							ajax_load();
							$.post('../PartSaleManage',form.serialize(),function(resData){			
								ajax_remove();
								if (resData.status == 'success') {
									window.location.reload();
								} else {
									alert(resData.status);
								}
							},'json');
						} else {
							alert('โปรดตรวจสอบจำนวน!');
							$('#other_qty').focus();
						}
					} else {
						alert('โปรดตรวจสอบส่วนลด!');
						$('#discount').focus();
					}
				} else {
					alert('โปรดตรวจสอบราคา!');
					$('#other_price').focus();
				}
			}
		});
		
		form.submit(function(){
			v;
			return false;
		});	
	});
	</script>
	
	<div class="txt_center m_top20">
		<input type="hidden" name="id" value="<%=WebUtils.getReqString(request, "id")%>">
		<input type="submit" name="add" class="btn_box btn_confirm" value="Submit">				
		<input type="button" class="btn_box btn_warn" value="Close Display" onclick="tb_remove();">				
		<input type="hidden" name="action" value="sale_other_add">
		<input type="hidden" name="create_by" value="<%=securProfile.getPersonal().getPer_id()%>">	
	</div>
</form>