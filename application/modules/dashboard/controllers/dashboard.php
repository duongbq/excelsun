<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of dashboard
 *
 * @author duongbq
 */
class Dashboard extends Backend_Controller
{

    function __construct()
    {
        parent::__construct();

    }

    function index()
    {
        $this->layout->title('Control panel - ExcelSun');
        $this->layout->view('index');
    }

}

