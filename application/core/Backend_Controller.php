<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of Backend_Controller
 *
 * @author duongbq
 */
class Backend_Controller extends MX_Controller
{

    function __construct()
    {
        parent::__construct();
        $this->_check_authentication();
        $this->set_up_layout();

    }

    /**
     * Check if user signed in or not
     */
    private function _check_authentication()
    {
        if (!modules::run('auth/is_logged_in')) {
            redirect(site_url('auth'));
        }
    }

    /**
     * Allow children class override this method
     */
    protected function set_up_layout()
    {
        $this->load->library('layout');
        $this->layout->title(lang('auth.title'));
        $this->layout->choose_layout('layouts/backend/backend');
    }

}

