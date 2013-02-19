/* 
 // 	Custom Events
 */

$(document).ready(function () {

    // Choose your style
    $('#style-changer a.close-btn').toggle(
        function () {
            $('div#style-changer').animate({left:-146})
        },
        function () {
            $('div#style-changer').animate({left:0})
        }
    )

    // Color Selector
    //$('div#colorSelector').ColorPicker({
    //color: '#0000ff',
    //onShow: function (colpkr) {
    //$(colpkr).fadeIn(500);
    //return false;
    //},
    //onHide: function (colpkr) {
    //$(colpkr).fadeOut(500);
    //return false;
    //},
    //onChange: function (hsb, hex, rgb) {
    //$('div##colorSelector div').css('backgroundColor', '#' + hex);
    //$('body').css('backgroundColor', '#' + hex);
    //}
    //});

    // Pattern Styles
    //$('div.pattern-styles a').click(function(){
    //$(this).addClass('current').parent().find('a').not($(this)).removeClass('current');
    //var _class = $(this).attr('rel');
    //$('#pattern').removeAttr('class').attr('class',_class);
    //})

    // Background Image Styles
    //$('div.bg-image-styles a').click(function(){
    //$(this).addClass('current').parent().find('a').not($(this)).removeClass('current');
    //var _class = $(this).attr('rel');
    //$('body').removeAttr('class').attr('class',_class);
    //})

});