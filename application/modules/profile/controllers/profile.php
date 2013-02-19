<?php
/**
 * Description of profile
 *
 * @author duongbq
 */
class Profile extends Backend_Controller
{

    function __construct()
    {
        parent::__construct();
        $this->load->model('account/Account_model');
        $this->load->model('profile/Profile_model');
    }

    /**
     * @param null $password
     */
    function change_profile($password = NULL)
    {
        //Prepare data for view
        $view_data = $this->_prepare_data_for_view();
        //If form is submitted
        if ($this->is_postback()) {
            if (!$this->Profile_model->update_profile(is_null($password) ? NULL : TRUE)) {
                $view_data['error'] = $this->Profile_model->get_last_message();
            } else {
                redirect('dashboard');
            }
        }
        $this->layout->js('/assets/scripts/fancybox/jquery.mousewheel-3.0.4.pack.js');
        $this->layout->js('/assets/scripts/fancybox/jquery.fancybox-1.3.4.pack.js');
        $this->layout->css('/assets/scripts/fancybox/jquery.fancybox-1.3.4.css');
        $this->layout->view(is_null($password) ? 'profile_form' : 'password_form', $view_data);
    }

    /**
     * @return array
     */
    private function _prepare_data_for_view()
    {
        $view_data = array();
        $current_user = $this->csession->get('logged_user');
        $view_data['roles'] = $this->Account_model->get_roles_by_account_id($current_user->id);
        $this->load->model('file/File_model');
        $file = $this->File_model->get_files_array();
        $view_data['avatar'] = isset($file[$current_user->file_id]) ? $file[$current_user->file_id] : NULL;
        return $view_data;
    }

    /**
     *
     */
    function change_avatar()
    {
        if ($this->is_postback()) {
            //@Todo: call model method to change avatar
            $this->Profile_model->update_avatar();
            redirect($this->input->post('current_url'));
        } else {
            redirect(base_url());
        }
    }
}

