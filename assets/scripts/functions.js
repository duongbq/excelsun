$(document).ready(function () {

    /*
     //	General Definations
     */
    // Global Variables
    var lastNavItem = "top";

    // Get window height and width
    var windowHeight = $(window).height();
    var windowWidth = $(window).width();

    var headerHeight = $('#header').outerHeight();

    //	Set min height to section areas
    $('div.section').css('min-height', (windowHeight - headerHeight));

    /*
     //	Cufon Definations
     */

    // If you don't want to use cufon, please comment or remove code below
//		Cufon.replace('div.section h1, div.section h2, div.section h3, div.section h4');
//		Cufon.replace('div.section div.section-heading h1', {textShadow: '1px 1px #000'});


    /*
     //	Pretty Photo Definations
     */

    $('a[rel^="prettyPhoto"]').prettyPhoto({
        animation_speed:'fast', /* fast/slow/normal */
        slideshow:false, /* false OR interval time in ms */
        autoplay_slideshow:false, /* true/false */
        opacity:0.80, /* Value between 0 and 1 */
        show_title:true, /* true/false */
        allow_resize:true, /* Resize the photos bigger than viewport. true/false */
        default_width:500,
        default_height:344,
        counter_separator_label:'/', /* The separator for the gallery counter 1 "of" 2 */
        theme:'dark_square', /* light_rounded / dark_rounded / light_square / dark_square / facebook */
        hideflash:false, /* Hides all the flash object on a page, set to TRUE if flash appears over prettyPhoto */
        wmode:'opaque', /* Set the flash wmode attribute */
        autoplay:true, /* Automatically start videos: True/False */
        modal:false, /* If set to true, only the close button will close the window */
        overlay_gallery:false, /* If set to true, a gallery will overlay the fullscreen image on mouse over */
        keyboard_shortcuts:true, /* Set to false if you open forms inside prettyPhoto */
        changepicturecallback:function () {
        }, /* Called everytime an item is shown/changed */
        callback:function () {
        } /* Called when prettyPhoto is closed */
    });

    /*
     //	Nivo Slider Definations
     */

//		$('#slider').nivoSlider({
//			effect:'random', //Specify sets like: 'fold,fade,sliceDown'
//			slices:15,
//			animSpeed:500, //Slide transition speed
//			pauseTime:3000,
//			startSlide:0, //Set starting Slide (0 index)
//			directionNav:true, //Next & Prev
//			directionNavHide:true
//		});

    /*
     //	Cycle Slider Definations
     */

    // If div has "portfolio-list" class is bigger than one item, create navigation and start slider
//		var maxItemHeight = 0;

    // Row number which is how much row showing in slider
//		var rowNumber = 2;

//		$('div.portfolio-item').each(function() {
//			if($(this).height() > maxItemHeight) {
//				maxItemHeight = $(this).outerHeight(true);
//			};
//		})

//		$('div#portfolio-slider').css({'height':(maxItemHeight*rowNumber)})
//
//		if($('div.portfolio-list').length > 1) {
//			$('#portfolio-slider').after('<div class="portfolio-nav">').before('<div class="portfolio-nav">');
//			$('#portfolio-slider').cycle({
//				fx: 'scrollLeft',
//				speed:  'slow',
//				timeout: 0,
//				pager:  '.portfolio-nav'
//			});
//		}

    /*
     // 	Main Navigation Definations
     */

    $('ul.navigation li a').live('click', function (event) {
        event.preventDefault();
        var id = $(this).attr('href');
        $.scrollTo(id, 800, {offset:-headerHeight});
        lastNavItem = id;
    })

    /*
     // 	Main Slider Navigation Definations
     */

    $('#slider a').live('click', function (event) {
        event.preventDefault();
        var id = $(this).attr('href');
        $.scrollTo(id, 800, {offset:-headerHeight});
        lastNavItem = id;
    })

    /*
     //	Portfolio Definations
     */

    // Porfolio Item Hover Behaviour
    $('div.portfolio-item').hover(
        function () {
            $(this).find('img').stop().animate({opacity:0.5});
        },
        function () {
            $(this).find('img').stop().animate({opacity:1});
        }
    )

    /*
     //	Form Definations
     */

    // Submit Event
    $('#contact-form a.button').click(function (event) {
        event.preventDefault();
        $('#contact-form form').submit();
    })


    /*
     // 	Social Network Definations
     */

    $('#social-network').find('img').css({'opacity':0.6});

    $('#social-network').find('img').hover(
        function () {
            $(this).stop().animate({opacity:1})
        },
        function () {
            $(this).stop().animate({opacity:0.6})
        }
    )

    /*
     // 	Window Resize Events
     */

    var _time = null;

    $(window).resize(function () {
        var headerHeight = $('#header').outerHeight();
        clearTimeout(_time);

        _time = setTimeout(function () {

            windowHeight = $(window).height();
            windowWidth = $(window).width();

            $('div.section').css('min-height', (windowHeight - headerHeight));

            $.scrollTo(lastNavItem, 800, {offset:-headerHeight});

        }, 800)

    })

})