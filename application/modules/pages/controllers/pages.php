<?php
/**
 * Created by JetBrains PhpStorm.
 * User: duongbq
 * Date: 2/6/13
 * Time: 1:56 PM
 * To change this template use File | Settings | File Templates.
 */
class Pages extends Frontend_Controller
{
    function __construct()
    {
        parent::__construct();
    }

    function view_page($page = 'home')
    {
        if ($page == 'home') {
            $this->layout->view('home');
        } elseif ($page == 'about') {
            $this->layout->title('About us - ' . DEFAULT_TITLE);
            $this->layout->view('about');
        } elseif ($page == 'contact') {
            $this->layout->title('Contact us - ' . DEFAULT_TITLE);
            $this->layout->view('contact');
        } elseif ($page == 'connection') {
            $this->layout->title('Connection - ' . DEFAULT_TITLE);
            $this->layout->view('connection');
        } elseif ($page == '404') {
            $this->layout->title('Error page - ' . DEFAULT_TITLE);
            $this->layout->view('404');
        }
    }


}
