<?php

/**
 * Created by JetBrains PhpStorm.
 * User: duongbq
 * Date: 1/31/13
 * Time: 2:20 PM
 * To change this template use File | Settings | File Templates.
 */
class Profile_model extends CI_Model
{
    //This variable will keep all errors messages
    private $_last_message = NULL;

    /**
     * Constructor
     */
    function __construct()
    {
        parent::__construct();
        $this->load->model('account/Account_model');
    }

    /**
     * @return errors messages if any
     */
    function get_last_message()
    {
        return $this->_last_message;
    }

    /**
     * @param null $password
     * @return bool
     * return true if update successful, otherwise return false
     */
    function update_profile($password = NULL)
    {
        //Validate input
        if (!$this->_validate(is_null($password) ? NULL : TRUE)) {
            return FALSE;
        }
        //Data from submitted form
        $data = array();
        if (is_null($password)) {
            $data = array(
                'id' => $this->csession->get('logged_user')->id,
                'first_name' => trim($this->input->post('first_name')),
                'last_name' => trim($this->input->post('last_name')),
                'dob' => date('Y-m-d', strtotime($this->input->post('dob'))),
                'email' => trim($this->input->post('email')),
                'username' => trim($this->input->post('username')),
                'sex' => $this->input->post('sex')
            );
        } else {
            $data = array(
                'id' => $this->csession->get('logged_user')->id,
                'password_digest' => md5(trim($this->input->post('conf_new_password')))
            );
        }
        //Save new profile
        $this->Account_model->update_account($data);
        //Update current session
        $auth_user = $this->Account_model->get_accounts($data);
        $this->csession->save('logged_user', $auth_user[0]);
        return TRUE;
    }

    /**
     * @param null $password
     * @return bool
     */
    private function _validate($password = NULL)
    {
        if (is_null($password)) {
            $this->form_validation->set_rules('first_name', 'First name', 'trim|required|max_length[255]|xss_clean');
            $this->form_validation->set_rules('last_name', 'Last name', 'trim|required|max_length[255]|xss_clean');
            $this->form_validation->set_rules('username', 'Username', 'trim|required|max_length[255]|xss_clean|callback_check_exist_username');
            $this->form_validation->set_rules('email', 'Email', 'trim|required|max_length[255]|valid_email|xss_clean|callback_check_exist_email');
        } else {
            $current_password = $this->csession->get('logged_user')->password_digest;
            $this->form_validation->set_rules('current_password', 'Current password', 'trim|required|md5|matches_value[' . $current_password . ']|xss_clean');
            $this->form_validation->set_rules('new_password', 'New password', 'required|max_length[255]|xss_clean');
            $this->form_validation->set_rules('conf_new_password', 'Confirm new password', 'trim|required|matches[new_password]|max_length[255]|xss_clean');
        }
        $this->form_validation->set_error_delimiters('<div class="message error closeable">', '</div>');
        if (!$this->form_validation->run($this)) {
            $this->_last_message = validation_errors();
            return FALSE;
        }
        return TRUE;
    }

    /**
     * @param $email
     * @return bool
     */
    function check_exist_email($email)
    {
        if ($email == $this->csession->get('logged_user')->email)
            return TRUE;
        $check_in_db = $this->Account_model->get_accounts(array('email' => trim(strtolower($email))));
        if (count($check_in_db) > 0) :
            $this->form_validation->set_message('check_exist_email', '<strong>"' . $email . '"</strong> has been already in use.');
            return FALSE;
        endif;
        return TRUE;
    }

    /**
     * @param $username
     * @return bool
     */
    function check_exist_username($username)
    {
        if ($username == $this->csession->get('logged_user')->username)
            return TRUE;
        $check_in_db = $this->Account_model->get_accounts(array('username' => trim($username)));
        if (count($check_in_db) > 0) :
            $this->form_validation->set_message('check_exist_username', '<strong>"' . $username . '"</strong> has been already in use.');
            return FALSE;
        endif;
        return TRUE;
    }

    function update_avatar()
    {
        $current_user = $this->csession->get('logged_user');
        //Load model to work with file
        $this->load->model('file/File_model');
        //Delete old avatar
        $this->File_model->delete_file(array('folder_name' => 'avatar', 'file_id' => $current_user->file_id));
        $options = array(
            'folder_name' => 'avatar',
            'img_process' => TRUE,
            'width' => 60,
            'height' => 60
        );
        //Upload image file with options above
        $return_val = $this->File_model->upload_file($options);
        //If problem, do nothing
        if ($return_val != NULL && !is_numeric($return_val)) {
            $this->_last_message = $return_val;
            return FALSE;
        }
        $data = array(
            'id' => $current_user->id,
            'file_id' => $return_val
        );
        //Save new file_id for accounts table
        $this->Account_model->update_account($data);
        //Update current session
        $auth_user = $this->Account_model->get_accounts($data);
        $this->csession->save('logged_user', $auth_user[0]);
        return TRUE;
    }
}
