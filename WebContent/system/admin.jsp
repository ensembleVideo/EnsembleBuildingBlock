
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.spvsoftwareproducts.blackboard.utils.B2Context" errorPage="../error.jsp" %>
<%@page import="edu.syr.ischool.mafudge.ensemblelib.*" errorPage="../error.jsp"%>
<%@taglib uri="/bbNG" prefix="bbNG" %>
<bbNG:genericPage title="${bundle['page.system.title']}" entitlement="system.admin.VIEW">
  <bbNG:cssFile href="../css/EnsembleB2.css" />
  
<%  
  B2Context b2Context = new B2Context(request);
  String cancelUrl = "index.jsp";

  if (request.getMethod().equalsIgnoreCase("POST")) {
    String servername = b2Context.getRequestParameter(SettingsKeys.SERVER_NAME, "").trim();
    String apikey = b2Context.getRequestParameter(SettingsKeys.CONSUMER_KEY, "").trim();
    String secretkey = b2Context.getRequestParameter(SettingsKeys.SHARED_SECRET, "").trim();
    String userkey = b2Context.getRequestParameter(SettingsKeys.USER_ATTRIBUTE, "").trim();
    String domain = b2Context.getRequestParameter(SettingsKeys.DOMAIN, "").trim();
    
    b2Context.setSetting(SettingsKeys.SERVER_NAME, servername);
    b2Context.setSetting(SettingsKeys.CONSUMER_KEY, apikey);
    b2Context.setSetting(SettingsKeys.SHARED_SECRET, secretkey);
    b2Context.setSetting(SettingsKeys.USER_ATTRIBUTE, userkey);
    b2Context.setSetting(SettingsKeys.DOMAIN, domain);
    b2Context.persistSettings();
    response.sendRedirect(cancelUrl + "?inline_receipt_message=" +
       b2Context.getResourceString("receipt.success"));
  }

  pageContext.setAttribute("bundle", b2Context.getResourceStrings());
  pageContext.setAttribute("cancelUrl", cancelUrl);
  
  Boolean isUsername = b2Context.getSetting(SettingsKeys.USER_ATTRIBUTE).isEmpty() ? true : b2Context.getSetting(SettingsKeys.USER_ATTRIBUTE).equals("username");
  
%>
  <bbNG:pageHeader instructions="${bundle['page.system.admin.instructions']}">
    <bbNG:breadcrumbBar environment="SYS_ADMIN_PANEL" navItem="admin_plugin_manage">
      <bbNG:breadcrumb href="index.jsp" title="${bundle['plugin.name']}" />
      <bbNG:breadcrumb title="${bundle['page.system.admin.title']}" />
    </bbNG:breadcrumbBar>
    <bbNG:pageTitleBar iconUrl="../images/powered.by.ensemble.gif" showTitleBar="true" title="${bundle['page.system.admin.title']}"/>
  </bbNG:pageHeader>
  <bbNG:form action="" id="id_simpleForm" name="simpleForm" method="post" onsubmit="return validateForm();">
  <bbNG:dataCollection markUnsavedChanges="true" showSubmitButtons="true">
    <bbNG:step hideNumber="true" id="stepOne" title="${bundle['page.system.admin.title']}" instructions="${bundle['page.system.admin.step1.instructions']}">
      <bbNG:dataElement isRequired="true" label="${bundle['page.system.admin.step1.servername.label']}">
        <bbNG:textElement id="serverName" name="<%=SettingsKeys.SERVER_NAME%>" value="<%=b2Context.getSetting(SettingsKeys.SERVER_NAME)%>" helpText="${bundle['page.system.admin.step1.servername.instructions']}" size="50" minLength="1" />
      </bbNG:dataElement>
      <bbNG:dataElement isRequired="true" label="${bundle['page.system.admin.step1.apikey.label']}">
        <bbNG:textElement id="apiKey" name="<%=SettingsKeys.CONSUMER_KEY%>" value="<%=b2Context.getSetting(SettingsKeys.CONSUMER_KEY)%>" helpText="${bundle['page.system.admin.step1.apikey.instructions']}" size="50" minLength="1" />
      </bbNG:dataElement>
      <bbNG:dataElement isRequired="true" label="${bundle['page.system.admin.step1.secretkey.label']}">
        <bbNG:textElement id="secretKey" name="<%=SettingsKeys.SHARED_SECRET%>" value="<%=b2Context.getSetting(SettingsKeys.SHARED_SECRET)%>" helpText="${bundle['page.system.admin.step1.secretkey.instructions']}" size="50" minLength="1" />
      </bbNG:dataElement>		
      <bbNG:dataElement isRequired="true" label="${bundle['page.system.admin.step1.userkey.label']}">
        <bbNG:selectElement name="<%=SettingsKeys.USER_ATTRIBUTE%>"  title="${bundle['page.system.admin.step1.userkey.instructions']}" >
        	<bbNG:selectOptionElement value="username" optionLabel="Blackboard Usernames + Optional Domain" isSelected="<%= isUsername %>" />
        	<bbNG:selectOptionElement value="email" optionLabel="Blackboard Email Address" isSelected="<%= !isUsername %>" />
        </bbNG:selectElement>
      </bbNG:dataElement>		
      <bbNG:dataElement isRequired="false" label="${bundle['page.system.admin.step1.domain.label']}">
        <bbNG:textElement id="domain" name="<%=SettingsKeys.DOMAIN%>" value="<%=b2Context.getSetting(SettingsKeys.DOMAIN)%>" helpText="${bundle['page.system.admin.step1.domain.instructions']}" size="50" minLength="0" />
      </bbNG:dataElement>		
    </bbNG:step>
    <bbNG:stepSubmit hideNumber="true" showCancelButton="true"  cancelUrl="${cancelUrl}"/>
  </bbNG:dataCollection>
  
  </bbNG:form>
  </bbNG:genericPage>
 