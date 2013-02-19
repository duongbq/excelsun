<?php
/**
 * Created by JetBrains PhpStorm.
 * User: duongbq
 * Date: 2/4/13
 * Time: 1:42 PM
 * To change this template use File | Settings | File Templates.
 */
class Media_Admin extends Backend_Controller
{
    function __construct()
    {
        parent::__construct();
        $this->load->model('Media_model');
    }

    function list_video($page = 1)
    {

        $this->layout->view('admin/list_video');
    }

    function new_video()
    {
        $view_data = array();
        if ($this->is_postback()) {
            if (!$this->Media_model->upload_media()) {
                $view_data['error'] = $this->Media_model->get_last_messages();
            } else {
                redirect('media/media_admin/list_video');
            }
        }

        $this->layout->view('media/admin/video_form', $view_data);
    }
}
