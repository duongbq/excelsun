<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of auth_model
 *
 * @author duongbq
 */
class Auth_model extends CI_Model
{

    private $_last_message = NULL;

    function __construct()
    {
        parent::__construct();
        $this->load->model('account/Account_model');
        $this->load->helper('cookie');
    }

    /**
     * Check for signed in or not
     * @return boolean
     */
    function is_signed_in()
    {
        //Check in session
        if ($this->csession->get('is_logged_in')) {
            return TRUE;
        }
        //Look up cookie
        $lookup_cookie = $this->_get_auth_from_cookie();
        if (!is_null($lookup_cookie)) {
            $this->csession->save('logged_user', $lookup_cookie[0]);
            $this->csession->save('is_logged_in', TRUE);
            return TRUE;
        }

        return FALSE;
    }

    function get_last_message()
    {
        return $this->_last_message;
    }

    function do_login()
    {
        //Validate before check in DB
        if (!$this->_validate()) {
            return FALSE;
        }

        $params = array(
            'username' => trim($this->input->post('username')),
            'password_digest' => md5($this->input->post('password')),
            'disable_account' => 0
        );
        $auth_user = $this->Account_model->get_accounts($params);

        if (count($auth_user) == 1) {
            //Save in session
            $this->csession->save('logged_user', $auth_user[0]);
            $this->csession->save('is_logged_in', TRUE);
            //Save in cookie
            if ($this->input->post('remember')) {

                $data = array(
                    'name' => 'user_id',
                    'value' => $this->encrypt->encode($auth_user[0]->id),
                    'expire' => 3600 * 24 * 2 //@TODO: This should be settings
                );
                set_cookie($data);
                //@TODO: Save information in activities table
            }
            return TRUE;
        }

        $this->_last_message = '<div class="message error closeable">' . lang('auth.message.error') . '</div>';
        return FALSE;
    }

    function do_logout()
    {
        $this->csession->clear();
        if (!is_null(get_cookie('user_id', TRUE))) {
            delete_cookie('user_id');
        }
    }

    private function _validate()
    {

        $this->form_validation->set_rules('username', 'Username', 'trim|required|xss_clean');
        $this->form_validation->set_rules('password', 'Password', 'trim|required|xss_clean');
        $this->form_validation->set_error_delimiters('<div class="message error">', '</div>');

        if (!$this->form_validation->run()) {

            $this->_last_message = validation_errors();
            return FALSE;
        }

        return TRUE;
    }

    private function _get_auth_from_cookie()
    {
        //decode hash user_id
        $account_id = $this->encrypt->decode(get_cookie('user_id', TRUE));
        $auth_user = $this->Account_model->get_accounts(array('id' => $account_id));

        return count($auth_user) == 1 ? $auth_user[0] : NULL;
    }

}

/* End of file auth_model.php */
/* Location: ./application/modules/auth/auth_model.php */

