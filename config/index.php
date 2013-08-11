<?php
// This script takes the place of your app's index.php
require 'prefork.php';
Prefork::use_ini_file( 'prefork.ini' );
if ( Prefork::start_agent() )
    exit; // Prefork worked!
// Otherwise load and run the app normally
require 'index2.php';
run_my_app();
exit;