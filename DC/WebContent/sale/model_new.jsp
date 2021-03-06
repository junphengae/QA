<%@page import="java.util.List"%>
<%@page import="com.bitmap.webutils.LinkControl"%>
<%@page import="com.bitmap.webutils.WebUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="/WEB-INF/lib/customtag.tld" prefix="bmp" %>
<jsp:useBean id="securProfile" class="com.bitmap.security.SecurityProfile" scope="session"></jsp:useBean>


<%
String brand_id = WebUtils.getReqString(request, "brand_id");
%>

<script type="text/javascript">
$(function(){
	
	var $msg = $('.msg_error');
	var $form = $('#modelForm');

	var v = $form.validate({
		submitHandler: function(){
			var addData = $form.serialize();
			ajax_load();
			$.post('../VehicleManage',addData,function(resData){
				ajax_remove();
				if (resData.status == 'success') {
					var model = resData.model;
					$('#model').append('<option value="' + model.model_id + '">' + model.model_name + '</option>');
					$('#model').val(model.model_id);
					
					$('#edit_model').show().attr('lang','model_edit.jsp?height=300&width=520&model_id=' + model.model_id + '&brand_id=<%=brand_id%>');
					tb_remove();
				} else {
					alert(resData.message);
				}
			},'json');
		}
	});
	
	$form.submit(function(){
		v;
		return false;
	});
});
</script>
<div>
	<form id="modelForm">
		<table cellpadding="3" cellspacing="3" border="0" style="margin: 0 auto;" width="485px">
			<tbody>
				<tr align="center" height="25"><td colspan="2"><h3>Create New Model</h3></td></tr>
				<tr>
					<td align="left" width="25%"><label>Model Name</label></td>
					<td align="left" width="75%">: <input type="text" autocomplete="off" name="model_name" id="model_name" class="txt_box s150 input_focus required"></td>
				</tr>
				<tr align="center" valign="bottom" height="30">
				<td colspan="2">
					<button type="submit" id="btnAdd" class="btn_box btn_confirm">Save</button>
					<input type="hidden" name="action" value="model_add">
					<input type="hidden" name="brand_id" value="<%=brand_id%>">
					<input type="reset" onclick="tb_remove();" value="ยกเลิก" class="btn_box">
					<input type="hidden" name="create_by" id="create_by" value="<%=securProfile.getPersonal().getPer_id()%>">
				</td>
			</tr>
			</tbody>
		</table>
		<div class="msg_error"></div>
	</form>
</div>