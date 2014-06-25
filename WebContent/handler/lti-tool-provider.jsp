<%@page contentType="text/html" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.*,
				java.net.*" 
		errorPage="../error.jsp"%>
<%@page import="com.spvsoftwareproducts.blackboard.utils.B2Context" errorPage="../error.jsp"%>
<%@page import="edu.syr.ischool.mafudge.ensemblelib.*" errorPage="../error.jsp"%>
<%@page import="blackboard.platform.blti.*"  errorPage="../error.jsp"%>
<%
	// This script sets up the launch of the Ensemble LTI Provider
	
	B2Context b2Context = new B2Context(request);
	pageContext.setAttribute("bundle", b2Context.getResourceStrings());
	EnsembleLTIConfiguration ec = new EnsembleLTIConfiguration(b2Context);

	String returnUrl = b2Context.getServerUrl() + b2Context.getPath() + "handler/process.jsp";
	
	// Basic LTI Setup / Handoff / get these from B2context.	
	Map<String, String> launchPresentation = new HashMap<String, String>();
	launchPresentation.put( BasicLTIConstants.PARAM_LAUNCH_PRESENTATION_DOCUMENT_TARGET, "iframe");
	launchPresentation.put( BasicLTIConstants.PARAM_LAUNCH_PRESENTATION_RETURN_URL, returnUrl );
	
	Map<String, String> customParams = new HashMap<String, String>();
	customParams.put("ensemble_username_param",ec.getUserAttributeLTI());
	if (ec.userAttributeIsUsername()) {
		customParams.put("user_id", ec.buildUsernameWithDomain(b2Context.getContext().getUser().getUserName()));	
	}	
	customParams.put( BasicLTIConstants.PARAM_RESOURCE_LINK_TITLE, "Ensemble Video");
	customParams.put( BasicLTIConstants.PARAM_TOOL_CONSUMMER_INFO_CODE, "bblearn");	
	
	BasicLTILauncher launcher = new BasicLTILauncher(ec.getLaunchUrl(), ec.getConsumerKey(), ec.getSharedSecret(), ec.getResourceId())
		.addCurrentCourseInformation()
		.addCurrentUserInformation(false, true, true, true)
		.addCustomToolParameters(customParams)
		.addLaunchPresentationInformation(launchPresentation);

	launcher.prepareParameters();
	
	launcher.launch(request, response, false, null);
%>
