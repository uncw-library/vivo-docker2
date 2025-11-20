/* $This file is distributed under the terms of the license in LICENSE$ */

$(document).ready(function(){
    // this will ensure that the hidden classgroup input is cleared if the back button is used
    // to return to th ehome page from the search results
    $('input[name="classgroup"]').val("");

    if ( $('section#home-geo-focus').length == 0 ) {
        $('section#home-stats').css("display","inline-block").css("margin-top","20px");
    }
 
});
