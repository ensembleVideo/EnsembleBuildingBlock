<%@page contentType="text/html" pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="blackboard.platform.session.*,
				java.util.*,
				java.net.*,
				blackboard.data.user.*,
				blackboard.persist.*,
				blackboard.data.course.*,
				blackboard.persist.course.*" 
		errorPage="../error.jsp"%>
<%@ page import="blackboard.platform.plugin.PlugInUtil" errorPage="../error.jsp"%>
<%@ page import="com.ensemblevideo.blackboard.*" errorPage="../error.jsp" %>
<%@ page import="com.spvsoftwareproducts.blackboard.utils.B2Context" errorPage="../error.jsp"%>
<%@ taglib uri="/bbNG" prefix="bbNG"%>
<%@ taglib uri="/bbData" prefix="bbData"%> 
<%
	String WYSIWYG_WEBAPP = "/webapps/wysiwyg";
	B2Context b2Context = new B2Context(request);
	String jQueryPath = b2Context.getPath() + "js/jquery.min.js";
	Cookie cookie = null;
	Cookie[] cookies = null;
	
	// retrieve the referrer, course id, and content id from the cookies collection
	String courseId = "";
	String contentId ="";
	String returnUrl = "";
	Boolean isVtbe = false;
	cookies = request.getCookies();
	if( cookies != null ){
	   for (int i = 0; i < cookies.length; i++){
	      cookie = cookies[i];
	      if((cookie.getName()).compareTo("http_ref") == 0 ){
	         returnUrl = URLDecoder.decode(cookie.getValue(),"UTF-8");
	      } else if ((cookie.getName()).compareTo("course_id") == 0 ){
		         courseId = cookie.getValue();
	      } else if ((cookie.getName()).compareTo("content_id") == 0 ){
		         contentId = cookie.getValue();
	      } else if ((cookie.getName()).compareTo("is_vtbe") == 0 ) {
	      		 isVtbe = Boolean.parseBoolean(cookie.getValue());
	      }
	   }
	}	
	
	// build the content HTML page
	// TODO: ev-script API will need to be extended to support a custom name
	String title = request.getParameter("title") == null ? "Ensemble" : request.getParameter("title");  
	String height = request.getParameter("height");
	String width = request.getParameter("width");
	String embedUrl = request.getParameter("url"); 
	// id=\"ensembleEmbeddedContent_xbyH5uJUtkmEb8XZJxfpfQ\" 
	String embedHtml = "<iframe src=\"" + embedUrl + "\"  frameborder=\"0\" style=\"width:"+ width + "px;height:"+ height + "px;\" height=\""+ height + "\" width=\""+ width + "\" allowfullscreen></iframe>";	
	
	// Check whether or not we came from vtbe
	if (isVtbe) {
		// Process the vtbe, then redirect.
	    request.setAttribute( "embedHtml", embedHtml );
	    String vtbeEmbedUrl = PlugInUtil.getInsertToVtbePostUrl().replace( WYSIWYG_WEBAPP, "" );
	    RequestDispatcher rd = getServletContext().getContext( WYSIWYG_WEBAPP ).getRequestDispatcher( vtbeEmbedUrl );
	    rd.forward( request, response );
	} else {
		// create the content item, show the page, and redirect
		ContentCreator cc = new ContentCreator();
		cc.createContent(title, embedHtml,courseId, contentId);	

// Use Markup and Javascript to redirect parent page back to main blackboard content page    
%>

<bbNG:genericPage> 
	<bbNG:jsFile href="<%=jQueryPath %>"/> 
	<p>Redirecting to <a id="returnUrl" href="<%=returnUrl %>"><%=returnUrl %></a>...</p>
	<script type="text/javascript">
		 jQuery.noConflict();
		     	      
	 	// Use jQuery via jQuery(...)
	 	jQuery(document).ready(function(){
	 		var returnUrl = jQuery("#returnUrl").attr("href");
	 		window.parent.location = returnUrl;
	 	});
	 </script>
</bbNG:genericPage>

<% 
	} // end if (isVtbe)
%>