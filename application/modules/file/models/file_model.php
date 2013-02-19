<?php
/**
 * Created by JetBrains PhpStorm.
 * User: duongbq
 * Date: 1/31/13
 * Time: 9:30 AM
 * To change this template use File | Settings | File Templates.
 */
class File_model extends CI_Model
{
    function __construct()
    {
        parent::__construct();
        $this->load->helper('file');
    }

    /**
     * Set where conditions for select query
     */
    private function _set_where()
    {
        if (isset ($params['id']))
            $this->db->where('files.id', $params['id']);
        if (isset ($params['file_name']))
            $this->db->where('file_name', $params['file_name']);
    }

    /**
     * @param array $params
     * @return objects(result set) array
     */
    function get_files($params = array())
    {
        $this->_set_where();
        return $this->db->get('files')->result();
    }

    /**
     * @param array $params
     * @return array
     */
    function get_files_array($params = array())
    {
        $files = $this->get_files($params);
        $output = array();
        foreach ($files as $file) {
            $output[$file->id] = $file->file_name;
        }
        return $output;
    }

    /**
     * @param array $data
     * @return id of record that has just inserted
     */
    function add_file($data = array())
    {
        $this->db->insert('files', $data);
        return $this->db->insert_id();
    }

    /**
     * @param array $options
     * @return null
     */
    public function delete_file($options = array())
    {
        // Get file
        $files = $this->get_files(array('id' => $options['file_id']));
        if (count($files) == 1) {
            // delete data from DB
            $this->db->where('id', $options['file_id']);
            $this->db->delete('files');
            // physically delete image file
            $config = $this->_config_upload();
            //Delete origin file
            if (file_exists($config['upload_path'] . $options['folder_name'] . '/' . $files[0]->file_name))
                unlink($config['upload_path'] . $options['folder_name'] . '/' . $files[0]->file_name);
            //Delete thumbnail file
            if (file_exists($config['upload_path'] . $options['folder_name'] . '/thumb/' . $files[0]->file_name))
                unlink($config['upload_path'] . $options['folder_name'] . '/thumb/' . $files[0]->file_name);
        }
    }

    /**
     * @param array $options
     * @return id
     */
    public function upload_file($options = array())
    {
        $config = $this->_config_upload($options);
        $this->load->library('upload', $config);

        if (!$this->upload->do_upload()) {
            return $this->upload->display_errors();
        } else {
            //Upload file to server
            $file = $this->upload->data();
            //Create directory if not existed
            $spec_dir = $config['upload_path'] . $options['folder_name'];
            $this->_create_directory($spec_dir);
            //Upload file is located by default in upload path
            $uploaded_file = $config['upload_path'] . $file['file_name'];
            //Rename with unique string
            $new_file_name = random_string('unique', date('YmdHis')) . $file['file_ext'];
            //Copy to specify folder
            copy($uploaded_file, $spec_dir . '/' . $new_file_name);
            //If params['img_process'] is set
            if (isset($options['img_process'])) {
                $this->_process_image($spec_dir . '/' . $new_file_name, $options);
                if (isset($options['thumbnail'])) {
                    $thumb_dir = $spec_dir . '/thumb';
                    $this->_create_directory($thumb_dir);
                    copy($spec_dir . '/' . $new_file_name, $thumb_dir . '/' . $new_file_name);
                    $this->_process_image($thumb_dir . '/' . $new_file_name, $options);
                }
            }
            //Delete origin file from upload path
            if (file_exists($uploaded_file)) {
                unlink($uploaded_file);
            }
            //save to DB and return File ID
            return $this->add_file(array('file_name' => $new_file_name));
        }
    }

    /**
     * @param array $options
     * @return array
     */
    private function _config_upload($options = array())
    {
        $config = array();
        //@Fixme Default upload_path should be received in settings module
        $config['upload_path'] = './uploads/';
        //@Fixme Default allowed_types should be received in settings module
        $config['allowed_types'] = isset($options['allowed_types']) ? $options['allowed_types'] : 'gif|jpg|png|doc|docx|pdf';
        //@Fixme
        $config['max_size'] = isset($options['max_size']) ? $options['max_size'] : 1024;
        $config['encrypt_name'] = TRUE;
        //Config images processing
        $config['image_library'] = 'gd2';
//        $config['source_image'] = $config['upload_path'] . $image['file_name'];
        $config['maintain_ratio'] = isset($options['maintain_ratio']) ? TRUE : FALSE;
        ;
        $config['width'] = isset($options['width']) ? $options['width'] : 400;
        $config['height'] = isset($options['height']) ? $options['height'] : 300;
        $config['thumb_width'] = isset($options['thumb_width']) ? $options['thumb_width'] : 40;
        $config['thumb_height'] = isset($options['thumb_height']) ? $options['thumb_height'] : 30;

        return $config;
    }

    /**
     * @param $directory
     */
    private function _create_directory($directory)
    {
        if (!file_exists($directory))
            mkdir($directory);
    }

    /**
     * @param $image_file
     * @param array $options
     * @return void
     */
    private function _process_image($image_file, $options = array())
    {
        $this->load->library('image_lib');
        $config = $this->_config_upload($options);
        $config['source_image'] = $image_file;
        $size = getimagesize($image_file);
        if ($size[0] < $size[1]) {
            $config['width'] = $size[1];
            $config['height'] = $size[0];
        }
        $this->image_lib->initialize($config);
        $this->image_lib->resize();
        $this->image_lib->clear();
    }

}
