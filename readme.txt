1. Working on your localhost (Linux) with apache2
    # sudo cp /etc/apache2/sites-available/default /etc/apache2/sites-available/excelsun.lc
    # sudo gedit /etc/apache2/sites-available/excelsun.lc (view excelsun.lc file for more details)
    # sudo gedit /etc/hosts (add 127.0.0.1	excelsun.lc as a new line and don't forget save it ^^! )
    # sudo a2ensite excelsun.lc
    # sudo /etc/init.d/apache2 restart
