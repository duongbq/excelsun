<?php
/**
 * Created by JetBrains PhpStorm.
 * User: duongbq
 * Date: 2/14/13
 * Time: 10:40 AM
 * To change this template use File | Settings | File Templates.
 */
class Captcha_model extends CI_Model
{
    function Captcha_model()
    {
        parent::__construct();
    }

    /**
     * @param array $options
     */
    function generate_captcha($options = array())
    {
        if (!isset($options['length']))
            $options['length'] = 3;
        if (!isset($options['width']))
            $options['width'] = 60;
        if (!isset($options['height']))
            $options['height'] = 25;
        if (!isset($options['fontsize']))
            $options['fontsize'] = 15;

        $code = '';
        $charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';

        for ($i = 1, $cslen = strlen($charset); $i <= $options['length']; $i++) {
            $code .= $charset{rand(0, $cslen - 1)};
        }

        $img = ImageCreate($options['width'], $options['height']);

        $bg_color = ImageColorAllocate($img, 153, 0, 2);
        $text_color = ImageColorAllocate($img, 255, 255, 255);
        $grid_color = ImageColorAllocate($img, 223, 0, 0);
        // fill the background
        ImageFilledRectangle($img, 0, 0, $options['width'], $options['height'], $bg_color);

        $angle = ($options['length'] >= 6) ? rand(-($options['length'] - 6), ($options['length'] - 6)) : 0;
        $x_axis = rand(6, (360 / $options['length']) - 16);
        $y_axis = ($angle >= 0) ? rand($options['height'], $options['width']) : rand(6, $options['height']);
        // create the spiral background
        $theta = 1;
        $thetac = 7;
        $radius = 16;
        $circles = 20;
        $points = 32;

        for ($i = 0; $i < ($circles * $points) - 1; $i++) {
            $theta = $theta + $thetac;
            $rad = $radius * ($i / $points);
            $x = ($rad * cos($theta)) + $x_axis;
            $y = ($rad * sin($theta)) + $y_axis;
            $theta = $theta + $thetac;
            $rad1 = $radius * (($i + 1) / $points);
            $x1 = ($rad1 * cos($theta)) + $x_axis;
            $y1 = ($rad1 * sin($theta)) + $y_axis;
            imageline($img, $x, $y, $x1, $y1, $grid_color);
            $theta = $theta - $thetac;
        }
        // print the text
        $x = 10;
        $y = $options['fontsize'] + 2;

        for ($i = 0; $i < strlen($code); $i++) {
            $y = $options['height'] / 5;
            imagestring($img, $options['fontsize'], $x, $y, substr($code, $i, 1), $text_color);
            $x += ($options['fontsize']);
        }

        $this->csession->save('captcha', $code);
//        $options['context']->csession->save('captcha', $code);

        header("Cache-Control: no-store, no-cache, must-revalidate");
        header("Content-Type: image/jpeg");
        imagejpeg($img, null, 100);
    }

}
