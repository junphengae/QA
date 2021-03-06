<%@page import="com.bmp.purchase.bean.PurchaseRequestBean"%>
<%@page import="com.bmp.purchase.bean.VendorBean"%>
<%@page import="com.bmp.purchase.bean.PurchaseOrderBean"%>
<%@page import="com.bmp.purchase.transaction.PurchaseOrderTS"%>
<%@page import="com.bitmap.bean.inventory.UnitType"%>
<%@page import="com.bitmap.utils.report.Mobile"%>
<%@page import="com.bitmap.bean.parts.Vendor"%>
<%@page import="com.bitmap.bean.parts.PartMaster"%>
<%@page import="com.bitmap.utils.Money"%>
<%@page import="com.bitmap.bean.inventory.InventoryMaster"%>
<%@page import="com.bitmap.bean.purchase.PurchaseRequest"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.bitmap.bean.purchase.PurchaseOrder"%>
<%@page import="com.bitmap.webutils.WebUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<link href="../css/style.css" rel="stylesheet" type="text/css">
<link href="../css/unit.css" rel="stylesheet" type="text/css">
<link href="../css/table.css" rel="stylesheet" type="text/css">
<link href="../css/loading.css" rel="stylesheet" type="text/css">

<script src="../js/jquery.min.js" type="text/javascript"></script>
<script src="../js/jquery.metadata.js" type="text/javascript"></script>
<script src="../js/jquery.validate.js" type="text/javascript"></script>
<script src="../js/thickbox.js" type="text/javascript"></script>
<script src="../js/loading.js" type="text/javascript"></script>
<script src="../js/number.js" type="text/javascript"></script>

<link href="../themes/vbi-theme/jquery.ui.all.css" rel="stylesheet" type="text/css">

<script src="../js/ui/jquery.ui.core.js"></script>
<script src="../js/ui/jquery.ui.widget.js"></script>
<script src="../js/ui/jquery.ui.datepicker.js"></script>

<jsp:useBean id="securProfile" class="com.bitmap.security.SecurityProfile" scope="session"></jsp:useBean>
<%@ taglib uri="/WEB-INF/lib/customtag.tld" prefix="bmp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%

String po = WebUtils.getReqString(request, "po");
PurchaseOrderBean PO = PurchaseOrderTS.selectInfo(po);
VendorBean vendor = PO.getUIVendor();
Iterator ite = PO.getUIOrderList().iterator();
%>
<title>สร้างใบสั่งซื้อ</title>
<style type="text/css">
.po_head table{border-collapse: collapse; width: 100%;}
.po_head table tr{border: 1px solid #111;}
.po_head table td{padding: 4px 3px;}
a.txt_red:hover{color: #cc0000;}
</style>

<script type="text/javascript">

$(function(){
	$( "#delivery_date" ).datepicker({
		showOtherMonths: true,
		selectOtherMonths: true,
		changeMonth: true,
		minDate: new Date(),
		hideIfNoPrevNext : true
	});
	
	/* var f_gross_amount = $('#gross_amount');
	var span_gross_amount = $('#span_gross_amount');
	var f_discount = $('#discount_pc');
	var f_discount_bath = $('#discount');
	var f_discount_bath_show = $('#discount_show');
	var span_discount =$('#span_discount');
	var f_net_amount = $('#net_amount');
	var span_net_amount =$('#span_net_amount');
	var f_vat = $('#vat');
	var vat_amount = $('#vat_amount');
	var span_vat = $('#span_vat');
	var span_grand_total = $('#span_grand_total');
	var grand_total = $('#grand_total');
	
	dc();
	
	f_discount_bath_show.blur(function(){
		dc();
	});
	
	f_discount.blur(function(){
		dc();
	});
	
	f_vat.blur(function(){
		dc();
	});
	
	function dc(){
		var net_amount = "0";
		var v = f_discount.val();
		
		if (v == '0' || v == '') {
			span_discount.text('0.00');
			span_net_amount.text(span_gross_amount.text());
			f_net_amount.val(f_gross_amount.val());
			
		
		} else {
			if (isNumber(v)) {
				net_amount = discount(parseFloat(f_gross_amount.val()), v);
				span_discount.text(discount_value(parseFloat(f_gross_amount.val()), v));
				span_net_amount.text(net_amount);
				f_net_amount.val(removeCommas(net_amount));
			} else {
				alert('กรุณาระบุ Discount ให้ถูกต้อง');
				f_discount.val('').focus();
				span_discount.text('0.00');
				span_net_amount.text(span_gross_amount.text());
				f_net_amount.val(f_gross_amount.val());
			}
		}
	dc_bath();
	}
	
	
	function dc_bath(){
		var net_amount = "0";
		var dis = removeCommas(f_discount_bath_show.val());
		
		if (dis == '0' || dis == '' || dis == '0.00') {
			f_discount_bath_show.val('0.00');
			f_discount_bath.val('0.00');
			
		}else {
			if (isNumber(dis)) {
				f_discount_bath.val(dis);
				f_discount_bath_show.text(money(dis));
				net_amount = parseFloat(removeCommas(span_net_amount.text())) - parseFloat(dis);
				span_net_amount.text(money(net_amount));
				f_net_amount.val(net_amount);	
			} else {
				alert('กรุณาระบุ Discount ให้ถูกต้อง');
				f_discount_bath_show.val('0.00').focus();
				f_discount_bath.val('0.00');
				net_amount = parseFloat(f_gross_amount.val()) - parseFloat(removeCommas(f_discount_bath_show.text()));
				span_net_amount.text(money(net_amount));
				f_net_amount.val(net_amount);
			}
		}
		
		vat();
	}
	
	
	
	function vat(){
		var v = f_vat.val();
		var net_amount = parseFloat(f_net_amount.val());
		var vat = "0";
		
		if (v == '0' || v == '') {
			span_vat.text('0.00');
			vat_amount.val('0');
			span_grand_total.text(money(f_net_amount.val()));
			grand_total.val(f_net_amount.val());
		} else {
			if (isNumber(v)) {
				vat = net_amount * (v / 100);
				span_vat.text(money(vat));
				vat_amount.val(money(vat));
				span_grand_total.text(money(net_amount + vat));
				grand_total.val(net_amount + vat);
	
			} else {
				alert('กรุณาระบุ VAT ให้ถูกต้อง');
				f_vat.val('').focus();
			}
		}
	}  */
	
	$('#btn_save').click(function(){
		if ($('#delivery_date').val() == '') {
			alert('โปรดระบุวันกำหนดส่งสินค้า');
			$('#delivery_date').focus();
		} else {
			if (confirm('ยืนยันการบันทึกใบสั่งซื้อ!\r\n** เมื่อยืนยันแล้วจะไม่สามารถแก้ไขใบสั่งซื้อนี้ได้อีก **')) {
				ajax_load();
				$.post('../PurchaseManageServlet',$('#issue_po_form').serialize(),function(resData){
					ajax_remove();
					if (resData.status == 'success') {
						
						window.location='po_info.jsp?po=<%=po%>';
					} else {
						alert(resData.message);
					}
				},'json');
			}
		}
	});
	
	$('.btn_remove').click(function(){
		if(confirm('ยืนยันการลบรายการออกจากใบสั่งซื้อนี้ !')){
			ajax_load();
			$.post('../PurchaseManageServlet',{'action':'remove_from_po','po':'<%=po%>','id':$(this).attr('data_id'),'mat_code':$(this).attr('mat_code'),'update_by':'<%=securProfile.getPersonal().getPer_id()%>'},function(resData){
				ajax_remove();
				if (resData.status == 'success') {
					window.location.reload();
				} else {
					alert(resData.message);
				}
			},'json');
		}
	});
	  
	
	
});
</script>

</head>
<body>

<div class="wrap_all">
	<jsp:include page="../index/header.jsp"></jsp:include>
	
	<div class="wrap_body">
		<div class="body_content">
			<div class="content_head">
				<div class="left">รายการใบสั่งซื้อ [PO] | สร้างใบสั่งซื้อ</div>
				<div class="right m_right10">
					<button class="btn_box" onclick="javasript: window.location='po_list.jsp';">กลับไปหน้ารายการสั่งซื้อ</button>
				</div>
				<div class="clear"></div>
			</div>
			
			<div class="content_body">
					<form id="issue_po_form" onsubmit="return false;">
					
						<div class="po_head s350 right">
							<table>
								<tr>
									<td>เลขที่ (P/O. NO.) </td><td>: <%=PO.getPo()%></td>
								</tr>
								<%if (PO.getReference_po().length() > 0) { %>
								<tr>
									<td>ออกแทน P/O. NO. </td><td>: <%=PO.getReference_po()%></td>
								</tr>
								<%}%>
								<tr>
									<td>วันที่ (Date) </td><td>: <%=WebUtils.getDateValue(PO.getCreate_date())%></td>
								</tr>
								<tr>
									<td>กำหนดส่ง (Delivery Date) <br/>
									<font color="red">***ต้องทำการเลือกรายการจัดซื้อก่อน</font>
									</td>
									<td valign="top">: <input type="text" name="delivery_date" id="delivery_date"  readonly="readonly" class="txt_box s100" value="<%=(PO.getDelivery_date()==null)?"":WebUtils.getDateValue(PO.getDelivery_date())%>"></td>
								</tr>
								
								<tr>
									<td>เครดิต (Credit) </td><td>: <span id="view_vendor_credit"><%=vendor.getVendor_credit() %></span></td>
								</tr>
							</table>
						</div>
						<div class="clear"></div>
						
						<div class="vendor_info b_1 m_top5 pd_5">
							<table width="98%" class="center">
								<tr height="24" valign="top">
									<td width="120">บริษัท (Order To)</td>
									<td>: 
										<span id="view_vendor_name"><%=vendor.getVendor_name() %></span>
										<%if(vendor.getVendor_name().length() > 0){ %>
										<div class="btn_box btn_confirm thickbox right" title="แก้ไขข้อมูลตัวแทนจำหน่าย" lang="vendor_edit_po.jsp?vendor_id=<%=vendor.getVendor_id()%>&po=<%=PO.getPo()%>">แก้ไข</div><div class="clear"></div>
										<%} %>
									</td>
								</tr>
								<tr height="24" valign="top">
									<td>ถึง (ATTN)</td>
									<td>: <span id="view_vendor_attn"><%=vendor.getVendor_contact()%></span></td>
								</tr>
								<tr height="24" valign="top">
									<td>โทร (TEL)</td>
									<td> 
										<div class="left s350">: <span id="view_vendor_phone"><%=Mobile.mobile(vendor.getVendor_phone()) %></span></div>
										<div class="left">แฟกซ์ (FAX) : <span id="view_vendor_fax"><%=Mobile.mobile(vendor.getVendor_fax()) %></span></div>
										<input type="hidden" name="vendor_id" id="vendor_id" value="<%=vendor.getVendor_id()%>">
										<div class="clear"></div>
									</td>
								</tr>
							</table>
						</div>
						 
						<div class="m_top5 center">
							
							<div class="right txt_right">
							<br/><br/>	
								<button class="btn_box btn_confirm thickbox" lang="po_issue_select_pr.jsp?width=850&height=400&po=<%=po%>&vendor_id=<%=vendor.getVendor_id()%>" title="รายการที่ได้รับการอนุมัติแล้ว">เพิ่มรายการ</button>
								
							</div>
							<div class="clear"></div>
							
							<table class="bg-image s950">
								<thead>
									<tr>
										<th align="center" width="6%">ที่<br>(No.)</th>
										<th valign="top" align="center" width="19%">รหัสสินค้า<br>(Part Number)</th>
										<th valign="top" align="center" width="36%">รายการสินค้า<br>(Description)</th>
										<th valign="top" align="center" width="10%">หน่วยนับ<br>(Units)</th>		
										<th valign="top" align="center" width="12%">จำนวน<br>(Quantity)</th>
										<th valign="top" align="center" width="12%">ราคาต่อหน่วย(฿)<br>(Unit Price)</th>
										<th valign="top" align="center" width="15%">จำนวนเงิน<br>(Amount)</th>
									</tr>
								</thead>
								<tbody>
								<%
								int i = 1;
							    Boolean hasCheck = false;
								String amount = "0";
								Double gross_amount = 0.00;
								String discount_pc = "0";
								String discount = "0";
								String net_amount = "0";
								String vat_amount = "0";
								String grand_total = "0";
								while(ite.hasNext()) {
									hasCheck = true;
									PurchaseRequestBean entity = (PurchaseRequestBean) ite.next();
									PartMaster master = PartMaster.select(entity.getMat_code());
									int qty = Integer.parseInt(entity.getOrder_qty()) ;
									Double price = Double.valueOf(entity.getOrder_price()) ;
									amount = Money.money(qty * price);  //(Amount)จำนวนเงิน
									
									gross_amount += Double.parseDouble(Money.removeCommas( amount ));
									
									
							
								%>
									<tr id="tr_<%=entity.getId()%>" valign="middle">
										<td align="center"><%=i++%></td>
										<td align="left"><%=master.getPn()%></td>
										<td align="left">
											<div class="thickbox pointer left" lang="../info/inv_master_info.jsp?width=800&height=380&mat_code=<%=entity.getMat_code()%>" title="ข้อมูลสินค้า">
												<%=master.getDescription()%> 
												
											</div>
											<div class="right">
												<a class="txt_red btn_remove pointer" data_id="<%=entity.getId()%>" mat_code="<%=entity.getMat_code()%>"> ลบ</a>
											</div>
											<div class="clear"></div>
										</td>
										<td align="left"> <%=UnitType.selectName(master.getDes_unit())%></td>
										<td align="right"><%=Money.moneyInteger(entity.getOrder_qty())%> <%//=master.getStd_unit()%></td>
										<td align="right"><%=Money.money(entity.getOrder_price())%></td>
										<td align="right"><%=amount%></td>
									</tr>
								<%
									}
								
								%> 
								
								<script type="text/javascript">
								$(function(){
									var discount_pc = $('#discount_pc');
									var span_discount = $('#span_discount');
									
									var discount = $('#discount');
									
									var vat = $('#vat');
									var span_vat = $('#span_vat');
									var vat_amount = $('#vat_amount');
									
									DiscountChang();
									discount_pc.keyup(function() {
										  //alert( ".keyup() " +discount_pc.val());
										  DiscountChang();
									});
									discount.keyup(function() {
										  //alert( ".keyup() " +discount.val());
										  DiscountChang();
									});
									vat.keyup(function() {
										  //alert( ".keyup() " +discount.val());
										  DiscountChang();
									});
									
									
									function DiscountChang() {
										
										var gross_amount = '<%=gross_amount%>';
										var v_discount_pc ='0.00';
										var v_discount    ='0.00';
										
										v_discount_pc = (( parseFloat(removeCommas(gross_amount)) *   parseFloat(removeCommas(discount_pc.val())) ) /100).toFixed(2) ;
										v_discount    =  parseFloat(removeCommas(discount.val())).toFixed(2);
										
										var v_grand_total = (gross_amount - (v_discount_pc - v_discount)).toFixed(2) ;
										var v_vat_amount  = (( v_grand_total * parseFloat(removeCommas(vat.val()))  )/107).toFixed(2) ;
										var v_net_amount  = (v_grand_total - v_vat_amount).toFixed(2) ;
										
										span_discount.text(money(v_discount_pc));
										span_vat.text(money(v_vat_amount));
										vat_amount.val(v_vat_amount);
										
										$('#span_grand_total').text(money(v_grand_total));
										$('#span_net_amount').text(money(v_net_amount));
										$('#grand_total').val(v_grand_total);
										$('#net_amount').val(v_net_amount);

									<%-- 	
										<%
										discount_pc = Money.money(( gross_amount * Double.parseDouble(Money.removeCommas( PO.getDiscount_pc() )) )/100)  ;
										discount    = Money.money(PO.getDiscount());
										grand_total = Money.money(gross_amount - Double.parseDouble(Money.removeCommas(discount_pc))- Double.parseDouble(Money.removeCommas(discount)));
										vat_amount  = Money.money((Double.parseDouble(Money.removeCommas(grand_total))*7)/107) ;
										net_amount  = Money.money(Double.parseDouble(Money.removeCommas(grand_total)) - Double.parseDouble(Money.removeCommas(vat_amount))) ;
										
										%> --%>
									
									
									}
									
									
								
								});
								
								</script>	
									<tr>
										<td colspan="6" align="right">รวมราคา (Gross Amount)</td>
										<td align="right"><span id="span_gross_amount"><%=Money.money(gross_amount) %></span><input type="hidden" name="gross_amount" id="gross_amount" value="<%=gross_amount%>"></td>
									</tr>
									<tr>
										<td colspan="6" align="right">ส่วนลด (Discount) 
											<input type="text" class="txt_box s30 txt_center" name="discount_pc" id="discount_pc" maxlength="3" value="<%=PO.getDiscount_pc()%>"> %</td>
										<td align="right"><span id="span_discount" ></span> 	
										</td>
									</tr>
									<tr>
										<td colspan="6" align="right">หรือ ส่วนลด (Discount) เป็นบาท</td>
										<td align="right">																					
											<input type="text" class="txt_box s_auto txt_right" name="discount" id="discount" value="<%=PO.getDiscount()%>"></td>
									</tr>
									<tr>
										<td colspan="6" align="right">รวมราคาหลังหักส่วนลด (Net Amount)</td>
										<td align="right">										
										<span id="span_net_amount"></span>
										<input type="hidden" name="net_amount" id="net_amount" value="0.00"></td>
									</tr>
									<tr>
										<td colspan="6" align="right">ภาษีมูลค่าเพิ่ม (VAT) <input type="text" class="txt_box s30 txt_center" name="vat" id="vat" value="<%=PO.getVat()%>"> %</td>
										<td align="right"><span id="span_vat"></span>
										<input type="hidden" name="vat_amount" id="vat_amount" value="0.00"></td>
									</tr>
									<tr class="txt_bold">
										<td colspan="6" align="right">รวมเป็นเงิน (Grand Total)</td>
										<td align="right">
										<span id="span_grand_total"></span>
										<input type="hidden" name="grand_total" id="grand_total" value="0.00"></td>
									</tr>
								</tbody>
							</table>
						</div>
						
						<div class="center right m_top5 pd_5">
							<div class="left">หมายเหตุ : </div> 
							<div class="left m_left5"><textarea name="note" class="txt_box s_600" rows="5" cols="55"><%=PO.getNote()%></textarea></div>
							<div class="clear"></div>
						</div>
						<div class="clear"></div>
						<!-- <input type="hidden" name="discount_" id="discount_">  -->
						<input type="hidden" name="po" value="<%=po%>">
						<input type="hidden" name="action" value="save_po">
						<input type="hidden" name="update_by" value="<%=securProfile.getPersonal().getPer_id()%>">
					</form>
					
					<div class="center txt_center m_top5">
					<%if(hasCheck){ %>
						<button class="btn_box btn_confirm" id="btn_save">บันทึกใบสั่งซื้อ</button>
						<%} %>
					</div>
				</div>
			
		</div>
	</div>
	<jsp:include page="../index/footer.jsp"></jsp:include>
</div>
</body>
</html>