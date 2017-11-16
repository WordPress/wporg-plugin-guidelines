<h4>15. The plugin version number must be incremented every time a new version is released.</h4>

Users will only be alerted to updates when the code version is incremented in SVN. Developers can deploy these updates either by incrementing the plugin version number in the readme.txt in the trunk branch or by creating a new tag branch with a readme.txt which has an incremented plugin version matching the branch directory name.

If a developer employs the tag directories approach to distribute the latest version of their plugin, the trunk folder can be continually updated without version number changes. The tag directories should generally not be updated past the initial tagging unless the readme.txt needs to be updated to support the release of a new version of WordPress.

For more information on tagging, please read our [SVN directions on tagging](https://developer.wordpress.org/plugins/wordpress-org/how-to-use-subversion/#task-3) and [how the readme.txt works](https://developer.wordpress.org/plugins/wordpress-org/how-your-readme-txt-works/).