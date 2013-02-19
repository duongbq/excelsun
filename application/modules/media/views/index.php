<script type="text/javascript" src="/assets/videoPlayer/swfobject.js"></script>
<script type="text/javascript" src="/assets/videoPlayer/fixMouseWheel.min.js"></script>
<style>
    .mouseWheelFix {
        width: 100%;
        height: 400px;
        margin-left: auto;
        margin-right: auto;
    }
</style>

<script type="text/javascript">
    swfobject.embedSWF("<?php echo base_url().'assets/videoPlayer/videoPlayer.swf'; ?>", "showItem", "620", "349", "9.0.0","",{
        // flash vars
        "player.xml":"<?php echo site_url('media/generate_video_xml_data');?>.xml"
    },{
        // params
        bgcolor:"#ffffff",
        allowfullscreen:"true"

    });
</script>
<div class="section" id="apropos">

    <div class="section-heading">
        <h1><strong>Excel<font color="#FFCC33">Sun</font></strong> Media</h1>
    </div>

    <div class="section-content">
        <div class="section-content-inner">

            <h2>Centre de bronzage <strong>Excel<font color="#FFCC33">Sun</font></strong></h2>

            <p align="justify">
                <div class="mouseWheelFix">
                    <div id="showItem"></div>
                </div>
            </p>

            <div class="clearboth"></div>
        </div>
    </div>
</div>