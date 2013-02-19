<div class="section">
    <div id="slider-container" class="theme-default">
        <div id="slider">
            <img src="/assets/images/content/MeganFox1.jpg" data-thumb="/assets/images/content/MeganFox1.jpg" alt=""/>
            <img src="/assets/images/content/slide_pic2.jpg" data-thumb="/assets/images/content/slide_pic2.jpg" alt=""
                 title="This is an example of a caption"/>
            <img src="/assets/images/content/slide_pic2.jpg" data-thumb="/assets/images/content/slide_pic2.jpg" alt=""
                 data-transition="slideInLeft"/>
            <img src="/assets/images/content/slide_pic2.jpg" data-thumb="/assets/images/content/slide_pic2.jpg" alt=""
                 title="#htmlcaption"/>
        </div>
        <div id="htmlcaption" class="nivo-html-caption">
            <strong>This</strong> is an example of a <em>HTML</em> caption with <a href="#">a link</a>.
        </div>
    </div>
</div>
<link rel="stylesheet" href="/assets/scripts/nivo-slider/nivo-slider.css" type="text/css" media="screen"/>
<link rel="stylesheet" href="/assets/scripts/nivo-slider/themes/default/default.css" type="text/css" media="screen"/>
<script type="text/javascript" src="/assets/scripts/nivo-slider/jquery.nivo.slider.js"></script>
<script>
    $(window).load(function () {
        $('#slider').nivoSlider();
    });
</script>