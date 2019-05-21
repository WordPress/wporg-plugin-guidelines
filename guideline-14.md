<h4>14. Frequent commits to a plugin should be avoided.</h4>

The Subversion (SVN) repository is a release repository, not a development one. All commits, code or readme files, will trigger a regeneration of the zip files associated with the plugin, so only code that is ready for deployment (be that a stable release, beta, or release candidate) should be pushed.

All commits are required to include a message. It is recommended this be descriptive and informative. Frequent commit messages like ‘update’ or ‘cleanup’ makes it hard for others to follow changes. Multiple, rapid-fire commits that only tweak minor aspects of the plugin (including the readme) cause undue strain on the system and can be seen as gaming Recently Updated lists.

An exception to this is when readme files are updated solely to indicate support of the latest release of WordPress.
