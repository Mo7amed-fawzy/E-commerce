let swiper = new swiper(".Slide-swp", {
    pagination: {
        el: ".swiper-pagination",
        dynamicBullests: true,
        clickable: true,
    },
    breakpoints:{
        1024:{
            slidesPerView: 2,
        },
        320:{
            slidesPerView: 1,
        },
    },
    autoplay:{
        delay: 3500,
    },
    loop: true,
});