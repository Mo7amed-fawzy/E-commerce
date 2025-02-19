let hidden_list = document.querySelector(".hidden-list");

function open_list(){
    hidden_list.classList.add("active")
}
function close_list(){
    hidden_list.classList.remove("active")
}

let home = document.querySelector("#home");
let pages = document.querySelector("#pages");
let blog = document.querySelector("#bolg");
let shop = document.querySelector("#shop");
let collections = document.querySelector("#collections");

function open_home(){
    home.classList.add("active");
}
function close_home(){
    home.classList.remove("active");
}
function open_pages(){
    pages.classList.add("active")
}
function close_pages(){
    pages.classList.remove("active");
}
function open_bolg(){
    blog.classList.add("active")
}
function close_bolg(){
    blog.classList.remove("active");
}
function open_shop(){
    shop.classList.add("active")
}
function close_shop(){
    shop.classList.remove("active");
}
function open_collections(){
    collections.classList.add("active")
}
function close_collections(){
    collections.classList.remove("active");
}


let swiper = new Swiper(".Slide-swp", {
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