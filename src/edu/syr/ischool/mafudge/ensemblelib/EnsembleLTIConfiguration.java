package edu.syr.ischool.mafudge.ensemblelib;

import com.spvsoftwareproducts.blackboard.utils.B2Context;

public class EnsembleLTIConfiguration {
	
	private String LTI_LAUNCH = "app/lti/launch.ashx";
	private String BB_LTI_EMAIL = "lis_person_contact_email_primary";
	private String BB_LTI_USERNAME = "custom_user_id";
	private String serverName;
	private String consumerKey;
	private String sharedSecret;
	private String userAttribute;
	private String domain;
	private String launchUrl;
	private String userAttributeLTI;
	private String resourceId;

	public EnsembleLTIConfiguration(B2Context context ) {
		this.serverName = context.getSetting(SettingsKeys.SERVER_NAME);
		this.consumerKey = context.getSetting(SettingsKeys.CONSUMER_KEY);
		this.sharedSecret = context.getSetting(SettingsKeys.SHARED_SECRET);
		this.userAttribute = context.getSetting(SettingsKeys.USER_ATTRIBUTE);
		this.domain = context.getSetting(SettingsKeys.DOMAIN);
		this.launchUrl = this.serverName.endsWith("/") ? this.serverName + this.LTI_LAUNCH : this.serverName + "/" + this.LTI_LAUNCH;
		this.userAttributeLTI = this.userAttribute.equalsIgnoreCase("username") ? this.BB_LTI_USERNAME : this.BB_LTI_EMAIL;
		this.resourceId = context.getServerUrl();
	}
		
	/*
	 * verifies the configuration is valid
	 */
	public Boolean isValid()  {
		return !(this.serverName.isEmpty() && this.consumerKey.isEmpty() && this.sharedSecret.isEmpty() && this.userAttribute.isEmpty());
	}
	
	public Boolean userAttributeIsUsername() {
		return this.userAttribute.equalsIgnoreCase("username");
	}
	
	public String buildUsernameWithDomain(String username ){
		return this.domain.isEmpty() ? username : username + "@" + this.domain;
	}
	public String getResourceId() {
		return this.resourceId;
	}
	
	public String getServerName() {
		return this.serverName;	
	}
	
	public String getLaunchUrl() {
		return this.launchUrl;
	}
	
	public String getUserAttributeLTI() {
		return this.userAttributeLTI;
	}
	
	public String getConsumerKey() {
		return this.consumerKey;
	}
	
	public String getSharedSecret() {
		return this.sharedSecret;
	}
	
	public String getDomain() {
		return this.domain;
	}
	
	public String getUserAttribute() {
		return this.userAttribute;
	}
}
