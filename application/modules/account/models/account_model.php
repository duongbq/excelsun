<?php
/**
 * Description of account_model
 *
 * @author duongbq
 */
class Account_model extends CI_Model
{

    function __construct()
    {
        parent::__construct();
    }

    private function _set_where($params)
    {

        if (isset($params['id']))
            $this->db->where('id', $params['id']);

        if (isset($params['email']))
            $this->db->where('email', $params['email']);

        if (isset($params['username']))
            $this->db->where('username', $params['username']);

        if (isset($params['password_digest']))
            $this->db->where('password_digest', $params['password_digest']);

        if (isset($params['disable_account']))
            $this->db->where('disable_account', $params['disable_account']);

        if (isset($params['sex']))
            $this->db->where('sex', $params['sex']);
    }

    function get_accounts($params = array())
    {

        $this->_set_where($params);

        if (isset($params['order_by']))
            $this->db->order_by($params['order_by']);
        else
            $this->db->order_by('first_name');

        if (isset($params['limit']) && isset($params['offset']))
            $this->db->limit($params['limit'], $params['offset']);

        return $this->db->get('accounts')->result();
    }

    function get_roles_by_account_id($account_id)
    {
        //Account has many roles
        //Get role_id array from account_role table
        $this->db->where('account_id', $account_id);
        $role_id_from_account_role = $this->db->get('account_role')->result();

        $role_ids = '';
        foreach ($role_id_from_account_role as $role) {

            if ($role_ids == '')
                $role_ids = $role->role_id;
            else
                $role_ids .= ', ' . $role->role_id;
        }

        if ($role_ids != '') {
            $this->load->model('role/Role_model');
            return $this->Role_model->get_role_tags(array('id_in_array' => $role_ids));
        } else {
            return NULL;
        }
    }

    function update_account($data = array())
    {
        if (isset($data['id'])) {
            $this->db->where('id', $data['id']);
            $this->db->update('accounts', $data);
        }
    }
}

