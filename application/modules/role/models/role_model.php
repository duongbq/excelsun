<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of role_model
 *
 * @author duongbq
 */
class Role_model extends CI_Model
{

    function __construct()
    {
        parent::__construct();
    }

    private function _set_where($params)
    {

        if (isset($params['id']))
            $this->db->where('id', $params['id']);

        if (isset($params['id_in_array']) && $params['id_in_array'] != "")
            $this->db->where('id in (' . $params['id_in_array'] . ')');

    }

    function get_roles($params = array())
    {
        $this->_set_where($params);
        $this->db->order_by('role_name');
        return $this->db->get('roles')->result();
    }

    function get_role_tags($params = array())
    {

        $role_tags = '';
        $roles = $this->get_roles($params);

        foreach ($roles as $role) {

            if ($role_tags == '')
                $role_tags = $role->role_name;
            else
                $role_tags .= ', ' . $role->role_name;
        }

        return $role_tags;
    }

    function get_role_array($params = array())
    {

        $output_array = array();

        foreach ($this->get_roles($params) as $role) {
            $output_array[$role->id] = $role->role_name;
        }

        return $output_array;
    }
}

