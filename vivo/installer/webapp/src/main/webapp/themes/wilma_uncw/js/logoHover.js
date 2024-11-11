/* $This file is distributed under the terms of the license in LICENSE$ */

$(document).ready(function () {
    var orig = $('.navbar-brand img').attr('src');
    $(".navbar-brand").on("mouseenter", function () {
        $('.navbar-brand img').attr('src', '/themes/wilma_uncw/images/uncw-logo-navy_222x222.svg');
    }).on("mouseleave", function () {
        $('.navbar-brand img').attr('src', orig);
    });
});
