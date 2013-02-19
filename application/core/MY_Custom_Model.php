<?php
/**
 * Created by JetBrains PhpStorm.
 * User: duongbq
 * Date: 2/18/13
 * Time: 1:27 PM
 * To change this template use File | Settings | File Templates.
 */
class MY_Custom_Model extends CI_Model
{
    function __construct(){
        parent::__construct();
    }

    function get_all_with_paging($options = array()){
        $total_row = $this->db->count_all($options['table_name']);
        $config = get_config_paging(array('page' => $options['page'], 'total_rows' => $total_row));
        $this->pagination->initialize($config);
        $pagination_link = $this->pagination->create_ajax_links();
        $this->db->limit($config['limit'], $config['offset']);
        return array($this->db->get($options['table_name'])->result(), $pagination_link);
    }

}
