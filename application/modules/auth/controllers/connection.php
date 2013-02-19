<?php
/**
 * Created by JetBrains PhpStorm.
 * User: duongbq
 * Date: 2/15/13
 * Time: 9:08 AM
 * To change this template use File | Settings | File Templates.
 */
class Connection extends Frontend_Controller
{
    function Connection()
    {
        parent::__construct();
    }

    function index()
    {
        $this->layout->title('Connection - ' . DEFAULT_TITLE);
        $this->layout->view('connection_form');
    }

}
