<h4>13. Plugins must use WordPress' default libraries.</h4>

WordPress includes a number of useful libraries, such as jQuery, Atom Lib, SimplePie, PHPMailer, PHPass, and more. For security and stability reasons plugins may not include those libraries in their own code. Instead plugins must use the versions of those libraries packaged with WordPress. 

While we do not yet have an updated public facing page to list all these libraries, please review the <a href="https://developer.wordpress.org/plugins/wordpress-org/external-libraries/">list of the external libraries included in WordPress from what is listed in the WordPress credits API</a>.

For a list of all javascript libraries included in WordPress, please review <a href="https://developer.wordpress.org/reference/functions/wp_enqueue_script/#default-scripts-and-js-libraries-included-and-registered-by-wordpress">Default Scripts Included and Registered by WordPress</a>.