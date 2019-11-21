<h2>Guide to submitting plugins to the Block Directory</h2>

The goal of the Block Directory is to provide a safe place for WordPress users to find and install new blocks.

<h3>User Expectations</h3>

* Users will have a place they can go, both within their WordPress admin and on WordPress.org, where they can download and install blocks that have been pre-vetted for major security issues. 
* Users will be able to one-click install blocks from their admin, one at a time.
* Blocks will appear in their block library after installation and activation.

<h3>Developer Expectations</h3>

* Developers will have a concrete set of requirements and guidelines to follow when writing blocks for the Block Directory

<h3>Definitions</h3>

First up, some clarity. For the purposes of the Block Directory, we distinguish between two types of plugins:
1. Plugins that exist solely to distribute a block.
1. All other plugins, including those that bundle many independent blocks, plugins that contain blocks in addition to other functionality, and plugins with no blocks at all.

These guidelines apply specifically to the first type of plugin, which we’ll call here a Block Plugin. If your plugin is of the second type, then the further guidelines and restrictions do not apply to your work. All plugins, be they block-only or not, are required to comply with the Detailed Plugin Guidelines https://developer.wordpress.org/plugins/wordpress-org/detailed-plugin-guidelines/.

<h3>Block Plugins and the Block Directory</h3>

The Block Directory contains only Block Plugins, that is to say plugins that contain only a single independent block and a minimum of supporting code. Block plugins have the following characteristics:

1. A specific type of WordPress plugin, with the same structure including a readme.txt file.
1. Containly only blocks (typically one).
1. Contain a minimum of server-side code. 
1. Do not have any UI outside of the post editor.

In addition to following the guidelines that apply to all WordPress plugins, Block Plugins that are submitted to the Block Directory must adhere to these guidelines:

<h3>Guidelines</h3>

<h4>1. Block Plugins are for the Block Editor.</h4>

Your block plugins should contain a block, and a minimum of other supporting code. It should not contain any UX outside of the editor, such as WordPress options or `wp-admin` menus. Server-side code should be kept to a minimum.

<h4>2. Block Plugins are separate blocks.</h4>

Block plugins are intended to be single purpose, separate, independent blocks, not bundles or compendiums of many blocks. In most cases, a Block Plugin should contain only one (single) block. It should not contain multiple blocks that could reasonably be split up into separate, independent plugins.

Block plugins may contain more than one block where a clearly necessary parent/child dependency exists; for example a list block that contains list item blocks.

<h4>3. Plugin titles should reflect the block title.</h4>

We want users to interact with blocks, not product names. Block Plugins should be named to reflect the block; for example "Image Grid" block, "Improved Slider", "Business Hours" block. Please avoid plugin names unrelated to the block itself like "Widgets Incorporated Block", and refrain from block names that include trademarks or names that you do not legally represent; for example you cannot name a block "Facerange Block" unless you work for Facerange and have their permission.

<h4>4. Block Plugins must include a <code>block.json</code> file.</h4>

The Block Registration RFC outlines the format of a `block.json` file: https://github.com/WordPress/gutenberg/blob/master/docs/rfc/block-registration.md

Block Plugins must include a valid `block.json` file. In addition to the requirements specified in the RFC, the `block.json` must include the following attributes:
* name
* title
* At least one of: script, editorScript
* At least one of: style, editorStyle

<h4>5. Block Plugins must not require payment or a paid account to function.</h4>

This includes payment for premium features. You may use the donation link feature.

<h4>6. Block Plugins should work independently.</h4>

Block Plugins must not require another plugin in order to function.

They may use an external/cloud API where necessary, but not if that API requires a paid account for access.

They should not rely on an external API or cloud service for functions that could be performed locally.

<h4>7. Server-side code should be kept to a minimum.</h4>

Since Block Plugins are WordPress plugins, they necessarily contain PHP code for metadata and initialisation. As much as possible, they should avoid including additional PHP code or server-side libraries. The WordPress REST API should be the preferred interface to WordPress, rather than custom server-side code.

We recognise that there are limits to the REST API, and situations where server-side PHP is the only performant way to implement a feature. In those situations, PHP code may be included. Please ensure that such code is clearly written, used as little as possible , and well documented.

<h4>8. Must not promote other blocks, plugins, or themes.</h4>

Block Plugins are blocks. They must not include advertisements, prompts, or promotional messages.
