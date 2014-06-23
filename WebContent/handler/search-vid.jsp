<%@page contentType="text/html" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="blackboard.platform.session.*,
				java.util.*,
				java.net.*,
				blackboard.data.user.*,
				blackboard.persist.*,
				blackboard.data.course.*,
				blackboard.persist.course.*" 
		errorPage="../error.jsp"%>
<%@page import="com.spvsoftwareproducts.blackboard.utils.B2Context" errorPage="../error.jsp"%>
<%@page import="blackboard.platform.blti.*"  errorPage="../error.jsp"%>
<%@ taglib uri="/bbNG" prefix="bbNG"%>
<%@ taglib uri="/bbData" prefix="bbData"%> 

<bbData:context id="ctx">
<%
	boolean isVtbe = request.getParameter("vtbe") != null ? true : false;
%>
<bbNG:learningSystemPage ctxId="ctx2" hideCourseMenu="<%=isVtbe %>" >

<bbNG:cssFile href="../css/EnsembleB2.css"/>

<%		
	B2Context b2Context = new B2Context(request);
	pageContext.setAttribute("bundle", b2Context.getResourceStrings());
	String ref  = request.getMethod().equalsIgnoreCase("POST") ? 
			request.getParameter("http_ref")!= null ? request.getParameter("http_ref") : ""   : 
			request.getHeader("referer")!= null ? URLEncoder.encode(request.getHeader("referer"),"UTF-8") : "";
	String processUrl = b2Context.getServerUrl() + b2Context.getPath() + "handler/lti-launch.jsp?vtbe=" + Boolean.toString(isVtbe);
%>
	
<bbNG:pageHeader instructions="Search Ensemble Video">
    <bbNG:pageTitleBar iconUrl="../images/powered.by.ensemble.gif" showTitleBar="true" title="Search for a video to add through this interface."/>
</bbNG:pageHeader>
<iframe style="width: 100%; height: 560px;" src="<%=processUrl %>"></iframe>
<p>DEBUG:<br />
processUrl = <%=processUrl %> <br>
</p>
</bbNG:learningSystemPage>
</bbData:context>