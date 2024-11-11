/* $This file is distributed under the terms of the license in LICENSE$ */

$(document).ready(function () {
    var orig = $('.navbar-brand img').attr('src');
    $(".navbar-brand").on("mouseenter", function () {
        $('.navbar-brand img').attr('src', 'https://uncw.edu/_global/img/uncw-logo-navy_222x222.svg');
    }).on("mouseleave", function () {
        $('.navbar-brand img').attr('src', orig);
    });
});
