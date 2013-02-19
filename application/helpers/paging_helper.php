<?php

if (!function_exists('get_config_paging')) {
    /**
     * @param array $options
     * @return array
     */
    function get_config_paging($options = array())
    {
        $config = array();
        $config['total_rows'] = $options['total_rows'];
        $config['per_page'] = isset($options['per_page']) ? $options['per_page'] : 3;

        $total_pages = (int)($options['total_rows'] / $config['per_page']);
        if ($total_pages * $config['per_page'] < $options['total_rows'])
            $total_pages++;
        if ((int)$options['page'] > $total_pages)
            $options['page'] = $total_pages;

        $config['offset'] = $options['page'] <= 1 ? 0 : ((int)$options['page'] - 1) * $config['per_page'];
        $config['limit'] = $config['per_page'];
        $config['num_links'] = isset($options['num_links']) ? $options['num_links'] : 5;
        $config['first_link'] = '«««';
        $config['prev_link'] = '«';
        $config['next_link'] = '»';
        $config['last_link'] = '»»»';
        $config['js_function'] = isset($options['js_function']) ? $options['js_function'] : 'change_page';
        return $config;
    }
}