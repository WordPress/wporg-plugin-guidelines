<h4>8. Plugins may not send executable code via third-party systems.</h4>

Externally loading code from documented services is permitted, however all communication must be made as securely as possible. Executing outside code within a plugin when not acting as a service is not allowed, for example:

<ul>
	<li>Serving updates or otherwise installing plugins, themes, or add-ons from servers other than WordPress.org’s</li>
	<li>Installing premium versions of the same plugin</li>
	<li>Calling third party CDNs for reasons other than font inclusions; all non-service related JavaScript and CSS must be included locally</li>
	<li>Using third party services to manage regularly updated lists of data, when not explicitly permitted in the service’s terms of use</li>
	<li>Using iframes to connect admin pages; APIs should be used to minimize security risks
</ul>

Management services that interact with and push software down to a site <em>are</em> permitted, provided the service handles the interaction on it's own domain and not within the WordPress dashboard.