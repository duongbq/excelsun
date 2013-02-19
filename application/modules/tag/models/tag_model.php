<?php
/**
 * User: duongbq
 * Date: 2/5/13
 * Time: 9:35 AM
 * To change this template use File | Settings | File Templates.
 */
class Tag_model extends CI_Model
{
    function __construct()
    {
        parent::__construct();
    }

    /**
     * @param $input
     * @return array
     */
    function split_tags($input)
    {
        $output = array();
        foreach (explode(',', $input) as $i => $o) {
            if (trim($o) != '')
                $output[$i] = trim($o);
        }
        return $output;
    }

    /**
     * @param array $data
     * @return mixed
     */
    public function add_tag($data = array())
    {
        $this->db->insert('tags', $data);
        return $this->db->insert_id();
    }

    function get_tags($params = array())
    {
        if(isset ($params['tag_name']))
            $this->db->where('tag_name', $params['tag_name']);
        if(isset ($params['id']))
            $this->db->where('id', $params['id']);

        $this->db->order_by('tag_name');

        return $this->db->get('tags')->result();
    }

}
