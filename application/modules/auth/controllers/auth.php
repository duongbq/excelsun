<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of auth
 *
 * @author duongbq
 */
class Auth extends MX_Controller
{

    function __construct()
    {
        parent::__construct();
        $this->load->model('Auth_model');
//        $this->output->enable_profiler(TRUE);
    }

    /**
     * This method is called by default
     */
    function index()
    {
        $this->login();
    }

    /**
     *
     * @return boolean
     */
    function is_logged_in()
    {

        if ($this->Auth_model->is_signed_in()) {
            return TRUE;
        }
        return FALSE;
    }

    public function logout()
    {
        //Destroy all session
        $this->Auth_model->do_logout();
        //lead end user to homepage
        redirect(base_url());
    }

    /**
     *
     */
    public function login()
    {
        //If already logged in or saved in cookie, lead to dashboard
        if ($this->is_logged_in()) {
            redirect(site_url('dashboard'));
        }

        $view_data = array();
        //If post back
        if ($this->is_postback()) {
            //Check in DB
            if (!$this->Auth_model->do_login())
                //If there is no user with password given, show error message
                $view_data['error'] = $this->Auth_model->get_last_message();
            else {
                //Lead to dashboard
                redirect(site_url('dashboard'));
            }
        }
        //If not post back load login form
        $this->load->view('auth/login_form', $view_data);
    }

}
