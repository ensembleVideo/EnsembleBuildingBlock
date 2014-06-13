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
<%@ taglib uri="/bbNG" prefix="bbNG"%>
<%@ taglib uri="/bbData" prefix="bbData"%> 
<bbData:context id="ctx">
<%
	boolean isVtbe = request.getParameter("vtbe") != null ? true : false;
%>
<bbNG:learningSystemPage ctxId="ctx2" hideCourseMenu="<%=isVtbe %>" >

<bbNG:cssFile href="../css/EnsembleB2.css"/>

<%

	// These will be needed for OAUTH implementation
	String SERVER_NAME = "server-name";
	String API_KEY = "api-key";
    String DOMAIN = "domain";
	String SECRET_KEY = "secret-key";
	
	
	B2Context b2Context = new B2Context(request);
	pageContext.setAttribute("bundle", b2Context.getResourceStrings());
	String courseId = request.getParameter("course_id");
	String contentId = request.getParameter("content_id");
	String ref  = request.getMethod().equalsIgnoreCase("POST") ? 
			request.getParameter("http_ref")!= null ? request.getParameter("http_ref") : ""   : 
			request.getHeader("referer")!= null ? URLEncoder.encode(request.getHeader("referer"),"UTF-8") : "";

	// process url depends on whether we arrived via VTBE or not.
	String processUrl = b2Context.getServerUrl() + b2Context.getPath() + "handler/" +(isVtbe ? "vtbe-search-vid-process.jsp" : "search-vid-process.jsp");
	
	// Setup cookies. these need to be saved so we can redirect back to where we came
	int expires = 60*60*24; // 24 hours
	Cookie httpRefCookie = new Cookie("http_ref", ref);
	Cookie courseIdCookie = new Cookie("course_id", courseId);
	Cookie contentIdCookie = new Cookie("content_id", contentId);
	httpRefCookie.setMaxAge(expires); 
	courseIdCookie.setMaxAge(expires);
	contentIdCookie.setMaxAge(expires);
	response.addCookie( httpRefCookie );
	response.addCookie( courseIdCookie );
	response.addCookie( contentIdCookie );

	String returnUrl = processUrl + "&product=canvas"; //&content_id=" + contentId + "&course_id=" + courseId + "&http_ref=" +ref;

%>
<bbNG:pageHeader instructions="Search Ensemble Video">
    <bbNG:pageTitleBar iconUrl="../images/powered.by.ensemble.gif" showTitleBar="true" title="Search for a video to add through this interface."/>
</bbNG:pageHeader>
<iframe style="width: 100%; height: 560px;" src="http://ensembledev/app/lti/index.aspx?returnUrl=<%=returnUrl%>"></iframe>
<p>DEBUG:<br />
returnUrl = <%=returnUrl %> <br>
referrer = <%=httpRefCookie.getValue() %><br>
courseId = <%=courseIdCookie.getValue() %><br>
contentId = <%=contentIdCookie.getValue() %><br>
</p>
</bbNG:learningSystemPage>
</bbData:context>