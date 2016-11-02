**7. The plugin may not “phone home” or track users without their informed, explicit, opt-in consent.**

In the interest of protecting user privacy, plugins may not contact external servers without the explicit consent of the user via requiring registration with a service or a checkbox within the settings. This method is called ‘opt in.’ Documentation on how any user data is collected, and used, should be included in the plugin’s readme, preferably with a clearly stated privacy policy.

This restriction includes the following:

* No unauthorized collection of user data. Users may be asked to submit information but it cannot be automatically recorded without  explicit confirmation from the user. 
* Intentionally misleading users into submitting information as a requirement for use of the plugin itself is prohibited.
* Images and scripts should be loaded locally as part of the plugin whenever possible. If external data (such as blocklists) is required, their inclusion must be made clear to the user.
* Any third party advertisement mechanisms used within the plugin must  have all tracking features disabled by default. Advertisement mechanisms which do not have the capability of disabling user tracking features are prohibited.

The sole exception to this policy is Software as a Service, such as Twitter, an Amazon CDN plugin, or Akismet. By installing, activating, registering, and configuring plugins that utilize those services, consent is granted for those systems.
