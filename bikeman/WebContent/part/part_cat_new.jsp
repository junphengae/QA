<%@page import="com.bitmap.webutils.WebUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<jsp:useBean id="securProfile" class="com.bitmap.security.SecurityProfile" scope="session"></jsp:useBean>
<%@ taglib uri="/WEB-INF/lib/customtag.tld" prefix="bmp" %>
<script type="text/javascript">
	$(function(){
		var $msg = $('#vendor_msg_error');
		var $form = $('#catForm');

		var v = $form.validate({
			submitHandler: function(){
				ajax_load();
				$.post('../PartManagement',$form.serialize(),function(data){
					ajax_remove();
					if (data.status == 'success') {
						$('select[name=cat_id]').append('<option value="' + data.cat_id + '">' + data.cat_name_th + ' ' + data.cat_name_short + '</option>');
						$('select[name=cat_id]').val(data.cat_id);
						$('#edit_cat').fadeIn(500).attr('lang','part_cat_edit.jsp?height=180&width=440&cat_id=' + data.cat_id + '&group_id=' + data.group_id);
						$('#new_sub_cat').fadeIn(500).attr('lang','part_sub_cat_new.jsp?height=180&width=440&cat_id=' +  data.cat_id + '&group_id=' + data.group_id);
						$('#sub_cat_id').html('<option value="">--- เลือกชนิดย่อย ---</option>');
						tb_remove();
					} else {
						alert(data.message);
						$('#catForm #cat_name_short').focus();
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
	<form id="catForm" action="" method="post" style="margin: 0;padding: 0;">
	<table cellpadding="3" cellspacing="3" border="0" style="margin: 0 auto;" width="420px">
		<tbody>
			<tr align="center" height="25"><td colspan="2"><h3>เพิ่มชนิด</h3></td></tr>
			<tr align="center" height="10px"><td colspan="2"></td></tr>
			<tr>
				<td align="left" width="20%"><label>ชื่อชนิด</label></td>
				<td align="left" width="80%">: <input type="text" autocomplete="off" name="cat_name_th" id="cat_name_th" class="txt_box s180 required input_focus"></td>
			</tr>
			<tr align="center" height="10px"><td colspan="2"></td></tr>
			<tr>
				<td><label>ชื่อย่อ</label></td>
				<td>: <input type="text" autocomplete="off" name="cat_name_short" id="cat_name_short" class="txt_box s180 required"  maxlength="4"></td>
			</tr>
			<tr align="left" height="25px"><td></td><td > <font color="red"> * ชื่อย่อ * ใส่ได้ไม่เกิน 4 ตัวอักษร</font></td></tr>
			<tr align="center" height="10px"><td colspan="2"></td></tr>
			<tr align="center" valign="bottom" height="30">
				<td colspan="2">
					<input type="submit" id="btnAdd" value="บันทึก" class="btn_box btn_confirm">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="hidden" name="action" value="cat_add">
					<input type="hidden" name="group_id" value="<%=WebUtils.getReqString(request, "group_id")%>">
					<input type="reset" onclick="tb_remove();" value="ยกเลิก" class="btn_box">
					<input type="hidden" name="create_by" value="<%=securProfile.getPersonal().getPer_id()%>">
				</td>
			</tr>
		</tbody>
	</table>
	<div class="msg_error" id="vendor_msg_error"></div>
	</form>

</div>