<%@page contentType="text/html" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.*,
				java.net.*" 
		errorPage="../error.jsp"%>
<%@page import="com.spvsoftwareproducts.blackboard.utils.B2Context" errorPage="../error.jsp"%>
<%@page import="blackboard.platform.blti.*"  errorPage="../error.jsp"%>
<%
	// This script sets up the launch of the Ensemble LTI Provider
	
	// TODO: These will be needed for OAUTH implementation, retrieved from settings, of course
	String SERVER_NAME = "server-name";
	String API_KEY = "api-key";
    String DOMAIN = "domain";
	String SECRET_KEY = "secret-key";
	
	B2Context b2Context = new B2Context(request);
	pageContext.setAttribute("bundle", b2Context.getResourceStrings());

	String returnUrl = b2Context.getServerUrl() + b2Context.getPath() + "handler/process.jsp";
	
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
