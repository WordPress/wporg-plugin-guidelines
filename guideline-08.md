**8. The plugin may not send executable code via third-party systems.**

Externally loading code from documented services is permitted, however all communication must be made as securely as possible. Executing outside code within a plugin when not acting as a service is not allowed, for example:

* Serving updates or otherwise installing plugins, themes, or add-ons from servers other than WordPress.org’s
* Installing premium versions of the same plugin
* Calling third party CDNs for reasons other than font inclusions; all non-service related javascript and CSS must be included locally
* Using third party services to manage regularly updated lists of data, when not explicitly permitted in the service’s terms of use
* Using iframes to connect admin pages; APIs should be used to minimize security risks