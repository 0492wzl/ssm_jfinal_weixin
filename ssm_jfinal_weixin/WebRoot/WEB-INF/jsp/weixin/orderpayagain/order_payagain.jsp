﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%>
<!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
</head>
<body class="no-skin">

	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
							
						<!-- 检索  -->
						<form action="ordPayAgain/list.do" method="post" name="Form" id="Form">
						<table style="margin-top:5px;">
							<tr>
								<td>
									<div class="nav-search">
										<span class="input-icon">
											<input type="text" placeholder="这里输入关键词" class="nav-search-input" id="keywords" name="keywords" autocomplete="off" value="${page.pd.keywords }" />
											<i class="ace-icon fa fa-search nav-search-icon"></i>
										</span>
									</div>
								</td>
								<td style="padding-left:2px;"><input class="span10 date-picker" name="lastStart" id="lastStart"  value="${pd.lastStart}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="开始日期" title="开始日期"/></td>
								<td style="padding-left:2px;"><input class="span10 date-picker" name="lastEnd" name="lastEnd"  value="${pd.lastEnd}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="结束日期" title="结束日期"/></td>										
								<c:if test="${QX.cha == 1 }">
								<td style="vertical-align:top;padding-left:2px"><a class="btn btn-xs btn-info" onclick="gsearch();"  title="检索">搜索</a></td>
								<!-- <td style="vertical-align:top;padding-left:20px;"><a class="btn btn-sm btn-success" onclick="toExcel();" title="导出到EXCEL">导出excel</a></td> -->
								</c:if>
							</tr>
						</table>
						<!-- 检索  -->
					
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">	
							<thead>
								<tr>
									<th class="center" style="width:50px;">序号</th>
									<th class="center">电话号码</th>
									<th class="center">会员昵称</th>
									<th class="center">产品名称</th>
									<th class="center">产品价格</th>
									<th class="center">结算价格</th>
									<th class="center">归属地</th>
									<th class="center">note</th>
									<th class="center">日志</th>
									<th class="center">支付状态</th>
									<th class="center">支付方式</th>
									<th class="center">充值状态</th>
									<th class="center">二次充值次数</th>
									<th class="center"><i class="ace-icon fa fa-clock-o bigger-110 hidden-480"></i>二次充值时间</th>
								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty varList}">
								<c:if test="${QX.cha == 1 }">
									<c:forEach items="${varList}" var="var" varStatus="vs">
										<tr onclick="showDetail('${var.order_id}')">
											<td class='center' style="width: 30px;">${vs.index+1}</td>
											<td class='center'>${var.phone}</td>
											<td class='center'>${var.nick_name}</td>
											<td class='center'>${var.product_name}</td>
											<td class='center'>${var.product_price}</td>
											<td class='center'>${var.settlement_price}</td>
											<td class='center'>
											<c:if test="${var.chnnl_type==1 }">中国移动</c:if>
											<c:if test="${var.chnnl_type==2 }">中国联通</c:if>
											<c:if test="${var.chnnl_type==3 }">中国电信</c:if>
											</td>
											<td class='center'>${var.note}</td>
											<td class='center'>${var.log}</td>
											<td class='center'>
											<c:if test="${var.paystatus==0 }">支付失败</c:if>
											<c:if test="${var.paystatus==1 }">支付成功</c:if>
											<c:if test="${var.paystatus==2 }">已退款</c:if>
											<c:if test="${var.paystatus==3 }">待付款</c:if>
											</td>
											<td class='center'>
											<c:if test="${var.settlement_method==1 }">微信支付</c:if>
											<c:if test="${var.settlement_method==2 }">钱包支付</c:if>
											</td>
											<td class='center'>
											<c:if test="${var.status==0 }">充值失败</c:if>
											<c:if test="${var.status==1 }">充值成功</c:if>
											<c:if test="${var.status==2 }">处理中</c:if>
											</td>	
											<td class='center'>${var.again_count}</td>
											<td class='center'>
											<fmt:formatDate value="${var.create_time}" type="both" pattern="yyyy-MM-dd HH:mm"/>
											</td>
										</tr>
									</c:forEach>
									</c:if>
									<c:if test="${QX.cha == 0 }">
										<tr>
											<td colspan="100" class="center">您无权查看</td>
										</tr>
									</c:if>
								</c:when>
								<c:otherwise>
									<tr class="main_info">
										<td colspan="100" class="center" >没有相关数据</td>
									</tr>
								</c:otherwise>
							</c:choose>
							</tbody>
						</table>
						<c:if test="${QX.cha == 1 }">
						<table>
						<a class="btn btn-sm btn-success" style="width:100px;">订单统计</a>
						</table>
						<table id="simple-tables" class="table table-striped table-bordered table-hover" style="margin-top:0px;">
							<thead>
								<tr>
									<th class="center" style="width:100px;">统计项</th>
									<th class="center">总订单数</th>
									<th class="center">总产品价格</th>
									<th class="center">总结算价格</th>
									<th class="center">总成本价格</th>
									<th class="center">总利润</th>
									
								</tr>
							</thead>
							<tr>
								<td class='center' style="width: 30px;">小计</td>
								<td class='center'>${total}</td>
								<td class='center'>${totalProductPrice}</td>
								<td class='center'>${totalSettlementPrice}</td>
								<td class='center'>${totalCostPrice}</td>
								<td class='center'>${totalProfit}</td>
							</tr>
						</table>
						
						<table style="width:100%;">
							<tr>
								<td style="vertical-align:top;">
								<div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div>
								</td>
							</tr>
						</table>
						</c:if>
						</div>
						</form>
					
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.page-content -->
			</div>
		</div>
		<!-- /.main-content -->


		<!-- 返回顶部 -->
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
			<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>

	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 删除时确认窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
		$(top.hangge());//关闭加载状态
		
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
			
			//下拉框
			if(!ace.vars['touch']) {
				$('.chosen-select').chosen({allow_single_deselect:true}); 
				$(window)
				.off('resize.chosen')
				.on('resize.chosen', function() {
					$('.chosen-select').each(function() {
						 var $this = $(this);
						 $this.next().css({'width': $this.parent().width()});
					});
				}).trigger('resize.chosen');
				$(document).on('settings.ace.chosen', function(e, event_name, event_val) {
					if(event_name != 'sidebar_collapsed') return;
					$('.chosen-select').each(function() {
						 var $this = $(this);
						 $this.next().css({'width': $this.parent().width()});
					});
				});
				$('#chosen-multiple-style .btn').on('click', function(e){
					var target = $(this).find('input[type=radio]');
					var which = parseInt(target.val());
					if(which == 2) $('#form-field-select-4').addClass('tag-input-style');
					 else $('#form-field-select-4').removeClass('tag-input-style');
				});
			}
			
			//行高亮控制  info  success  active
			var active_class = 'active';    
			$("#simple-table tr").mouseover(function(){
			             $(this).addClass(active_class);
			             $(this).css("cursor", "pointer");
			}).mouseout(function(){
			             $(this).removeClass(active_class);
			});
			$("#simple-tables tr").mouseover(function(){
			             $(this).addClass(active_class);
			}).mouseout(function(){
			             $(this).removeClass(active_class);
			});			
			
/* 			$('#simple-table > thead > tr > th input[type=checkbox]').eq(0).on('click', function(){
				var th_checked = this.checked;//checkbox inside "TH" table header
				$(this).closest('table').find('tbody > tr').each(function(){
					var row = this;
					if(th_checked) $(row).addClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', true);
					else $(row).removeClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', false);
				});
			}); */
		});
		
		//检索
		function gsearch(){
			top.jzts();
			$("#Form").submit();
		}
		function showDetail(id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="二次充值记录明细";
			 diag.URL = '<%=basePath%>ordPayAgain/goRecord.do?detail_id=' + id;
			 diag.Width = 700;
			 diag.Height = 600;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 nextPage(${page.currentPage});
				}
				diag.close();
			 };
			 diag.show();
		}
		
<%--         function toExcel(){
        
        var keyword = $("#keywords").val();
        var time1 = $("#lastStart").val();
        var time2 = $("#lastEnd").val();
        if( typeof(time2) == "undefined" ){
            time2 = "${pd.lastEnd}";
            time2 = time2.substring(0, 10);
        }        
			window.location.href='<%=basePath%>ordFail/excel.do?keywords='+ keyword +'&lastStart='+time1
			+'&lastEnd='+time2;        
		} --%>
	</script>



</body>
</html>