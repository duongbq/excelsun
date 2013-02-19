<style>
    body {
        font-family: arial;
        font-size: 13px;
    }

    p {
        font-family: arial;
        font-size: 13px;
        line-height: 1.5em;
        margin-bottom: 6px;
        margin-top: 3px;
    }
</style>

<p>Howdy administrator,</p>

<p>You have got a new contact at ExcelSun system:</p>

<p>
    First name: <strong><?php echo $first_name; ?></strong>
    <br/>
    Last name: <strong><?php echo $last_name; ?></strong>
    <br/>
    Email: <strong><a href="mailto:<?php echo $email; ?>"><?php echo $email; ?></a></strong>
    <br/>
    Tel: <strong><?php echo $tel; ?></strong>
    <br/>
    Message: <strong><?php echo $message; ?></strong>
</p>

<p>
    Have a good time!
</p>