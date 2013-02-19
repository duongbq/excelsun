<?php echo '<?xml version="1.0" encoding="utf-8"?>' . "\n"; ?>
<config>
    <watermark resource="/assets/images/content/logo.png" align="bottom,left" alpha="0.9"/>
    <controls hd="false" show="over"/>
    <fullscreen resizable="true" hideCursor="30"/>
    <style global="light">
        <text><![CDATA[
        title {color: #008EB0;font-family: Sapir Sans;font-size: 18px;text-align: center;}
        description {
            color: #666666;
            font-family: Sapir Sans;
            font-size: 13px;
            text-align: left;
        }
        index {
            color: #FFD209;
            font-family: Sapir Sans;
            font-size: 10px;
            font-weight: bold;
            text-align: center;
        }
        share {
            color: #FFFFFF;
            font-family: Sapir Sans;
            font-size: 13px;
            text-align: center;
        }
        label {
            color: #CCCCCC;
            font-family: Sapir Sans;
            font-size: 15px;
            text-align: center;
        }]]></text>
    </style>

    <share>
        <!-- hide embed code -->
        <embed show="true"/>
        <!--
            ******** IMPORTANT ********

            before enabling embed code features, you'll have to make all paths
            absolute, please refer to help file
        -->

        <!-- global default sharing options -->
        <settings
                embedSwf="true"
                url=""
                swfurl=""
                width=""
                height=""
                title=""
                description=""
                screenshot=""
                icons="/assets/videoPlayer/addThis"
                >

            <label><![CDATA[Partagez cette vidéo <br>(Sélectionnez un réseau social)<br><br>]]></label>

        </settings>
        <!-- for each item, you can set custom sharing options -->
        <item type="email"/>
        <item type="facebook" embedSwf="true" title="Playlist player"
              description="here comes a customizable description text"
              screenshot="/assets/images/content/logo.png" width="320" height="240"/>
        <item type="twitter"/>
        <item type="digg"/>
        <item type="myspace"/>
        <item type="delicious"/>
        <item type="tumblr"/>
        <item type="blogger"/>
        <item type="technorati"/>
        <item type="bebo"/>
        <item type="linkedin"/>
        <item type="netvibes"/>
        <item type="reddit"/>
        <item type="virb"/>
        <item type="wordpress"/>
        <item type="more"/>
    </share>


    <start resource="http://confor.us/videos/Lz5AaEbbavVPPPQ31281710019.flv"
           cover="http://confor.us/thumbs/Lz5AaEbbavVPPPQ31281710019.jpg">
        <caption>
            <![CDATA[<title><a href="index.php/video/play/100170">Communication 2</a></title>]]>
        </caption>
    </start>

</config>