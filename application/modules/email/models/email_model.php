<?php
/**
 * Created by JetBrains PhpStorm.
 * User: duongbq
 * Date: 2/14/13
 * Time: 3:10 PM
 * To change this template use File | Settings | File Templates.
 */
class Email_model extends CI_Model
{
    function __construct()
    {
        parent::__construct();
        $this->load->library('email');
    }

    /**
     * @param array $options
     */
    function send_email($options = array())
    {
        //Initializes all the email variables to an empty state
        $this->email->clear();

        $sender_email = isset($options['sender_email']) ? $options['sender_email'] : DEFAULT_SENDER_EMAIL;
        $sender_name = isset($options['sender_name']) ? $options['sender_name'] : DEFAULT_SENDER_NAME;
        $this->email->from($sender_email, $sender_name);

        $this->email->subject($options['subject']);

        $this->email->message($options['message']);

        $this->email->to($options['to_email']);

        if (isset($options['cc_email']))
            $this->email->cc($options['cc_email']);

        if (isset($options['bcc_email']))
            $this->email->cc($options['bcc_email']);

        if (isset($options['attach']))
            $this->email->attach($options['attach']);

        $this->email->send();
    }

}
