<%@page contentType="text/html" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.*,
				java.net.*" 
		errorPage="../error.jsp"%>
<%@page import="com.spvsoftwareproducts.blackboard.utils.B2Context" errorPage="../error.jsp"%>
<%@page import="blackboard.platform.blti.*"  errorPage="../error.jsp"%>
<%

	// These will be needed for OAUTH implementation, retrieved from settings, of course
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
	boolean isVtbe = request.getParameter("vtbe") != null ? true : false;
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

	String returnUrl = processUrl; // + "&product=canvas"; //&content_id=" + contentId + "&course_id=" + courseId + "&http_ref=" +ref;
	
	// Basic LTI Setup / Handoff / get these from B2context.
	String launchUrl = "http://ensembledev/app/lti/launch.ashx";
	String resourceId = b2Context.getServerUrl();
	String apiKey = "52af905c-187a-4405-ab61-0bbec3e7e62f";
	String apiSecret = "6A9A832F-698F-4ECB-8C40-3616A0E3F4D6";
	
	Map<String, String> launchPresentation = new HashMap<String, String>();
	launchPresentation.put( BasicLTIConstants.PARAM_LAUNCH_PRESENTATION_DOCUMENT_TARGET, "iframe");
	launchPresentation.put( BasicLTIConstants.PARAM_LAUNCH_PRESENTATION_RETURN_URL, returnUrl );
	
	Map<String, String> customParams = new HashMap<String, String>();
	customParams.put("ensemble_username_param","lis_person_contact_email_primary");
	customParams.put( BasicLTIConstants.PARAM_RESOURCE_LINK_TITLE, "Ensemble Video");
	customParams.put( BasicLTIConstants.PARAM_TOOL_CONSUMMER_INFO_CODE, "canvas");
	
	BasicLTILauncher launcher = new BasicLTILauncher(launchUrl, apiKey, apiSecret, resourceId)
		.addCurrentCourseInformation()
		.addCurrentUserInformation(false, true, true, true)
		.addCustomToolParameters(customParams)
		.addLaunchPresentationInformation(launchPresentation);

	launcher.prepareParameters();
	
	launcher.launch(request, response, false, null);
%>
