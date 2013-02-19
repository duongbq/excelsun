<?php
/**
 * Created by JetBrains PhpStorm.
 * User: duongbq
 * Date: 2/4/13
 * Time: 4:33 PM
 * To change this template use File | Settings | File Templates.
 */
class Media_Model extends CI_Model
{
    private $_last_message = NULL;

    function __construct()
    {
        parent::__construct();
    }

    function get_last_messages()
    {
        return $this->_last_message;
    }

    /**
     * @return bool
     */
    function upload_media()
    {
        //Validate input
        if (!$this->_validate()) {
            return FALSE;
        }
        //Upload media file
        $return_val = $this->_upload_video_file();
        //If problem, do nothing
        if ($return_val != NULL && !is_numeric($return_val)) {
            $this->_last_message = '<div class="message error closeable">' . $return_val . '</div>';
            return FALSE;
        }
        //Insert new record to videos table
        $data = array(
            'account_id' => $this->csession->get('logged_user')->id,
            'title' => trim($this->input->post('title')),
            'description' => trim($this->input->post('description')),
            'file_id' => $return_val,
            'uploaded_date' => date('Y-m-d H:i:s')
        );
        $video_id = $this->_insert_video_info($data);
        $this->_insert_video_tags($video_id, $this->input->post('tags'));
        return TRUE;
    }

    /**
     * @param $video_id
     * @param $tags
     */
    private function _insert_video_tags($video_id, $tags)
    {
        $this->load->model('tag/Tag_model');
        $tags_name_array = $this->Tag_model->split_tags($tags);
        foreach ($tags_name_array as $tag_name) {
            //Insert into tags table and get return tag_id
            $tag_id = $this->Tag_model->add_tag(array('tag_name' => $tag_name));
            //Insert into video_tag table with video_id and tag_id
            $this->_add_video_tag(array('video_id' => $video_id, 'tag_id' => $tag_id));
        }
    }

    /**
     * @param array $data
     */
    private function _add_video_tag($data = array())
    {
        $this->db->insert('video_tag', $data);
    }

    private function _insert_video_info($data = array())
    {
        $this->db->insert('videos', $data);
        return $this->db->insert_id();
    }

    /**
     * @return mixed
     */
    private function _upload_video_file()
    {
        $this->load->model('file/File_model');
        //Upload media file
        $options = array(
            'folder_name' => 'media',
            'max_size' => 1024 * 3,
            'allowed_types' =>
            'mov|mpeg|mp3|avi|flv'
        );
        return $this->File_model->upload_file($options);
    }

    /**
     * @return bool
     */
    private function _validate()
    {
        $this->form_validation->set_rules('title', 'Video title', 'trim|required|max_length[255]|xss_clean');
        $this->form_validation->set_error_delimiters('<div class="message error closeable">', '</div>');
        if (!$this->form_validation->run()) {
            $this->_last_message = validation_errors();
            return FALSE;
        }
        return TRUE;
    }

    function get_video_xml_data($vid)
    {
        header('Content-Transfer-Encoding: binary');
        header('Content-Type: text/xml');
        header('Content-Disposition: filename="config.xml"');

        $data['watermark_resource'] = 'path_to_logo';
        $data['controls_show'] = $row['controls_show'];
        $data['controls_hd'] = $row['controls_hd'];
        $data['fullscreen_resizable'] = $row['fullscreen_resizable'];
        $data['fullscreen_hideCursor'] = $row['fullscreen_hideCursor'];
        $data['style_global'] = $row['style_global'];
        $data['embed'] = $row['embed'];
    }

}
