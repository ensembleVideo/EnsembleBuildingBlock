
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
<%@ taglib uri="/bbNG" prefix="bbNG"%>
<%@ taglib uri="/bbData" prefix="bbData"%> 
<%@ page isErrorPage="true" %>
<bbData:context id="ctx">
<%
	boolean isVtbe = request.getParameter("vtbe") != null ? true : false;
%>
<bbNG:learningSystemPage ctxId="ctx2" hideCourseMenu="<%=isVtbe %>" >

<bbNG:cssFile href="../css/EnsembleB2.css"/>

<%
	String SERVER_NAME = "server-name";
	String API_KEY = "api-key";
    String DOMAIN = "domain";
	String SECRET_KEY = "secret-key";
	String MY_MEDIA = "myMedia";
	String SHARED_MEDIA= "sharedMedia";
	String INST_CONTENT= "instContent";
	B2Context b2Context = new B2Context(request);
	String jQueryPath = b2Context.getPath() + "js/jquery.min.js";
	pageContext.setAttribute("bundle", b2Context.getResourceStrings());
	String courseId = ctx.getCourseId().toString();  
	String contentId = ctx.getContentId().toString();
	String userName = ctx.getUser().getUserName();
	String searchText = request.getParameter("searchText"); 
	String ref  = request.getMethod().equalsIgnoreCase("POST") ? 
			request.getParameter("http_ref")!= null ? request.getParameter("http_ref") : ""   : 
			request.getHeader("referer")!= null ? URLEncoder.encode(request.getHeader("referer"),"UTF-8") : "";
	String searchSource = (request.getParameterValues("searchSource")!= null ? request.getParameterValues("searchSource")[0] : MY_MEDIA );
	Boolean isMedia = (searchSource.equalsIgnoreCase(MY_MEDIA));
	Boolean isShared = (searchSource.equalsIgnoreCase(SHARED_MEDIA));
	Boolean isInstContent = (searchSource.equalsIgnoreCase(INST_CONTENT));
	
	String DEBUG = ""; //isVtbe? "U Used VBTE" : "U Used Content Handler";
	// Sanitize the search text input replaceAll("[^A-Za-z0-9 ]", "") and replace " " with "+"
	//searchText = searchText!=null ? searchText.replaceAll("[^A-Za-z0-9 ]","") : "";	
	//String encodedSearchText = searchText!=null ? searchText.replaceAll(" ","+") : "";
	String encodedSearchText = searchText != null ? URLEncoder.encode(searchText,"UTF-8"): ""; 
	// need to encode again to pass the "%" symbol on the query string.
	encodedSearchText = encodedSearchText.contains("%") ? URLEncoder.encode(encodedSearchText,"UTF-8") : encodedSearchText;
	String processUrl = isVtbe ? "vtbe-search-vid-process.jsp" : "search-vid-process.jsp";
%>
<bbNG:jsFile href="<%=jQueryPath %>"/> 
<bbNG:pageHeader instructions="Search Ensemble Video">
    <bbNG:pageTitleBar iconUrl="../images/powered.by.ensemble.gif" showTitleBar="true" title="Search for a video to add through this interface."/>
</bbNG:pageHeader>
<iframe style="width: 100%; height: 560px;" src="http://ensembledev/app/lti/index.aspx?returnUrl=http://blackboard/webapps/ist-Ensemble-Building-Block-BBLEARN/handler/search-vid-process.jsp&product=canvas">

</iframe>
</bbNG:learningSystemPage>
</bbData:context>