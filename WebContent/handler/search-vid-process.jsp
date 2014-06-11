<%@ page import="blackboard.platform.plugin.PlugInUtil" errorPage="../error.jsp"%>
<%@ page import="com.spvsoftwareproducts.blackboard.utils.B2Context" errorPage="../error.jsp"%>
<%@ page import="edu.syr.ischool.mafudge.ensemblelib.*" errorPage="../error.jsp" %>
<%@ page import="java.util.*,
				java.net.*" 
		errorPage="../error.jsp"%>
<%@ taglib uri="/bbData" prefix="bbData"%> 
<bbData:context id="ctx">
<%
// TODO: debug this to find out what the courseId and contentId might be. you may need to save these across the LTI exchange.

	String SERVER_NAME = "server-name";
	String API_KEY = "api-key";
	String SECRET_KEY = "secret-key";
    String DOMAIN = "domain";
	B2Context b2Context = new B2Context(request);
	String WYSIWYG_WEBAPP = "/webapps/wysiwyg";
	String courseId = ctx.getCourseId().toString(); // WAS: request.getParameter("course_id");
	String contentId = ctx.getContentId().toString();  // WAS: request.getParameter("content_id");
	//String returnUrl = URLDecoder.decode(request.getParameter("http_ref"),"UTF-8");
	String title = "Ensemble";

	String embedHtml = "<iframe id=\"ensembleEmbeddedContent_xbyH5uJUtkmEb8XZJxfpfQ\" src=\"http://ensembledev/app/plugin/embed.aspx?ID=xbyH5uJUtkmEb8XZJxfpfQ&displayTitle=false&startTime=0&autoPlay=false&hideControls=false&showCaptions=false&width=1280&height=694&displaySharing=false\" frameborder=\"0\" style=\"width:1280px;height:800px;\" height=\"800\" width=\"1280\" allowfullscreen></iframe>";	
	ContentCreator cc = new ContentCreator();
	cc.createContent(title, embedHtml,courseId, contentId);

	// TODO: This needs courseid, contentid, and referrer as read from search-vid.jsp
	// what do i do here????
   // response.sendRedirect(returnUrl); // + "&inline_receipt_message=Content%20Added.");
    
%>
</bbData:context>