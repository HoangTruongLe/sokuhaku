;

// smoothScroll
function smoothScrollJs() {
  smoothScroll.init({
    selector: '[data-scroll]',
    selectorHeader: '[data-scroll-header]',
    speed: 1000,
    easing: 'easeOutQuart',
    offset: 0,
    updateURL: true,
    callback: function () {}
  });
}

// sticky
function stickyClassJs() {
  var sticky = $('body');
  $(window).scroll(function() {
    if ($(this).scrollTop() > 0) {
      sticky.addClass('sticky');
    } else {
      sticky.removeClass('sticky');
    }
  });
}

// drawer
function drawerJs() {
  $('.drawer').drawer({
    class: {
    nav: 'drawer-nav',
    toggle: 'drawer-toggle',
    overlay: 'drawer-overlay',
    open: 'drawer-open',
    close: 'drawer-close',
    dropdown: 'drawer-dropdown'
    },
    iscroll: {
    // Configuring the iScroll
    // //github.com/cubiq/iscroll#configuring-the-iscroll
    mouseWheel: true,
    preventDefault: false
    },
    showOverlay: true
  });
}

// slick
function slickJs() {
  $(".js-slider").slick({
    arrows: true,
    dots: true,
    infinite: true,
    speed: 600,
    slidesToShow: true,
    autoplay: false,
    adaptiveHeight: true
  });
}
$(function() {
  smoothScrollJs();
  stickyClassJs();
});
