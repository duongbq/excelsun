<?php
/**
 * Created by JetBrains PhpStorm.
 * User: duongbq
 * Date: 2/2/13
 * Time: 4:51 PM
 * To change this template use File | Settings | File Templates.
 */
class Activity_model extends CI_Model
{
    function __construct()
    {
        parent::__construct();
    }

    function add_activity($data = array())
    {
        $this->db->insert('activities', $data);
        return $this->db->insert_id();
    }
}
