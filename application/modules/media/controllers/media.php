<?php
/**
 * Created by JetBrains PhpStorm.
 * User: duongbq
 * Date: 2/4/13
 * Time: 10:31 AM
 * To change this template use File | Settings | File Templates.
 */
class Media extends Frontend_Controller
{
    function __construct()
    {
        parent::__construct();
        $this->load->model('Media_model');
    }

    function index(){
        $this->layout->view('index');
    }

    function generate_video_xml_data(){
        $view_data = array();
//        $view_data = $this->Media_model->get_video_xml_data($vid);
        header('Content-Transfer-Encoding: binary');
        header('Content-Type: text/xml');
        header('Content-Disposition: filename="config.xml"');
        $this->load->view('generate_video_xml_data', $view_data);
    }


}
