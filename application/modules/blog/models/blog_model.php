<?php
/**
 * Created by JetBrains PhpStorm.
 * User: duongbq
 * Date: 2/15/13
 * Time: 11:22 AM
 * To change this template use File | Settings | File Templates.
 */
class Blog_model extends CI_Model
{
    function Blog_model()
    {
        parent::__construct();
    }

    /**
     * @param int $page
     * @return array
     */
//    function get_all_blogs_with_paging($page = 1)
//    {
//        $total_row = $this->db->count_all('blogs');
//        $config = get_config_paging(array('page' => $page, 'total_rows' => $total_row));
//        $this->pagination->initialize($config);
//        $pagination = $this->pagination->create_ajax_links();
//
//        return array($this->get_blogs($config), $pagination);
//    }

    /**
     * @param array $params
     * @return mixed
     */
    function get_blogs($params = array())
    {
        $this->_set_where($params);

        if (isset($params['limit']) && isset($params['offset']))
            $this->db->limit($params['limit'], $params['offset']);

        return $this->db->get('blogs')->result();

    }

    function get_tags_by_blog_id($blog_id)
    {
        $this->db->where('blog_id', $blog_id);
        $this->db->select('blog_tag.*, tags.tag_name');
        $this->db->join('tags','tags.id = blog_tag.tag_id');
        $tags = $this->db->get('blog_tag')->result();
        $blog_tags = '';
        foreach ($tags as $tag)
        {
            $encode_tag = mb_strtolower(url_title(removesign($tag->tag_name)));
            if ($blog_tags == '')
                $blog_tags = anchor("tags/search/{$encode_tag}", $tag->tag_name);
            else
                $blog_tags .= ', ' . anchor("tags/search/{$encode_tag}", $tag->tag_name);
        }
        return $blog_tags;
    }

    function get_blog_meta_tag($blog_id)
    {
        $this->db->where('blog_id', $blog_id);
        $meta = $this->db->get('blog_meta')->result();
        if(count($meta) == 1){
            return array($meta[0]->keywords, $meta[0]->description);
        }
        return NULL;
    }

    /**
     * @param array $params
     */
    private function _set_where($params = array())
    {

        if (isset($params['id']))
            $this->db->where('id', $params['id']);
        if (isset($params['search'])) {
            $where = "(title like'%" . $params['search'] . "%'";
            $where .= " or sumary like'%" . $params['search'] . "%'";
            $where .= " or content like'%" . $params['search'] . "%')";
            $this->db->where($where);
        }
    }

}
