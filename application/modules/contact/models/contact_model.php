<?php
/**
 * Created by JetBrains PhpStorm.
 * User: duongbq
 * Date: 2/14/13
 * Time: 1:09 PM
 * To change this template use File | Settings | File Templates.
 */
class Contact_model extends CI_Model
{
    private $_last_message = '';

    function Contact_model()
    {
        parent::__construct();
    }

    /**
     * @return string
     */
    function get_last_message()
    {
        return $this->_last_message;
    }

    function add_new_contact()
    {
        //Validate input
        if (!$this->_validate()) {
            return FALSE;
        }

        $data = array(
            'first_name' => trim($this->input->post('first_name')),
            'last_name' => trim($this->input->post('last_name')),
            'email' => trim($this->input->post('email')),
            'tel' => trim($this->input->post('tel')),
            'message' => trim($this->input->post('message')),
        );
        $this->db->insert('contacts', $data);
        $this->_send_contact_email($data);
        return TRUE;
    }

    private function _send_contact_email($data = array())
    {
        $this->load->model('email/Email_model');
        $options = array(
            'sender_name' => $data['first_name'] . ' ' . $data['last_name'],
            'sender_email' => $data['email'],
            'subject' => 'New contact message at ExcelSun',
            'message' => $this->load->view('contact/contact_email', $data, TRUE),
            'to_email' => 'duongbq83@gmail.com' //@TODO: this value should be received from settings module
        );
        $this->Email_model->send_email($options);
    }

    private function _validate()
    {
        $this->form_validation->set_rules('first_name', 'First name', 'trim|required|max_length[255]|xss_clean');
        $this->form_validation->set_rules('last_name', 'Last name', 'trim|required|max_length[255]|xss_clean');
        $this->form_validation->set_rules('email', 'Email', 'trim|required|max_length[255]|valid_email|xss_clean');
        $this->form_validation->set_rules('message', 'Message', 'trim|required|max_length[500]|xss_clean');
        $this->form_validation->set_error_delimiters('<div class="message error closeable">', '</div>');
        $captcha = $this->csession->get('captcha');
        $this->form_validation->set_rules('security_code', 'Security code', 'trim|required|matches_value[' . $captcha . ']|xss_clean');
        if (!$this->form_validation->run()) {
            $this->_last_message = validation_errors();
            return FALSE;
        }
        return TRUE;
    }


}
