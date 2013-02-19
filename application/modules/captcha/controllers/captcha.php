<?php
/**
 * Created by JetBrains PhpStorm.
 * User: duongbq
 * Date: 2/6/13
 * Time: 3:27 PM
 * To change this template use File | Settings | File Templates.
 */
class Captcha extends CI_Controller
{
    function __construct()
    {
        parent::__construct();
    }

    /**
     *
     */
    function generate_captcha()
    {
        $this->load->model('Captcha_model');
        $this->Captcha_model->generate_captcha();
    }

}
