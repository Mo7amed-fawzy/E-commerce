const langSec = document.querySelector('.languageSection');
const buttons = document.querySelectorAll('.dropdown-item');


const textTitle = document.querySelector('.title');
const textDesc = document.querySelector('.description');
const textDelivery = document.querySelector('.delivery-text');
const logintxt = document.querySelector('.logintext');
const Comparetext = document.querySelector('.Comparetext');
const Carttext = document.querySelector('.Carttext');

const Hometext = document.querySelector('.Hometrnslat');
const pagestext = document.querySelector('.pagestranslat');
const blogtext = document.querySelector('.blogtranslat');
const shoptext = document.querySelector('.shoptranslat');
const collectiontext = document.querySelector('.collectiontranslat');
const Specialtext = document.querySelector('.Specialstranslat');

const allcatigory = document.querySelector('.allctigorytranslat');


buttons.forEach(button => {
    button.addEventListener('click', () => {
        langSec.querySelector('.activeLang').classList.remove('activeLang');
        button.classList.add('activeLang');

        const attr = button.getAttribute('language');

        textTitle.textContent = data[attr].title;
        textDesc.textContent = data[attr].description;
        textDelivery.textContent = data[attr].delivery;
        logintxt.textContent = data[attr].login;
        Comparetext.textContent = data[attr].Compare;
        Carttext.textContent = data[attr].Cart;

        Hometext.textContent = data[attr].Home
        pagestext.textContent = data[attr].pages
        blogtext.textContent = data[attr].blog
        shoptext.textContent = data[attr].shop
        collectiontext.textContent = data[attr].collection
        Specialtext.textContent = data[attr].Special

        allcatigory.textContent = data[attr].allcatigory

        // Update the language dropdown label
        document.getElementById('languageDropdown').innerHTML = `<i class="fa-solid fa-flag"></i> ${button.textContent}`;
        // Template Literal
    });
});



const data = {
    "english": {
        "title": "Hotline:",
        "description": "1800 - 132 3218",
        "delivery": "Free Delivery",
        "login": "Login",
        "Compare": "Compare",
        "Cart": "My Cart",

        "Home": "Home",
        "pages": "pages",
        "blog": "blog",
        "shop": "shop",
        "collection": "collections",
        "Special": "Special",

        "allcatigory": "All Category",

    },
    "arabic": {
        "title": "الخط الساخن:",
        "description": "١٨٠٠ - ١٣٢ ٣٢١٨",
        "delivery": "توصيل مجاني",
        "login": "تسجيل الدخول",
        "Compare": "مقارنة",
        "Cart": "عربتي",
        "Home": "الصفحة الرئيسية",
        "pages": "الصفحات",
        "blog": "عرض",
        "shop": "المتجر",
        "collection": "المجموعات",
        "Special": "خاص",
        
        "allcatigory": "كل الاصناف",
    }
};




        // اكواد البوب اب
        
        function showPopup() {
            document.getElementById('newsletterPopup').classList.add('show');
            document.body.classList.add('no-scroll'); //بوقف السكرول 
        }

    function closePopup() {
        document.getElementById('newsletterPopup').classList.remove('show');
        document.body.classList.remove('no-scroll'); // برجع السكرول
    }

    window.onload = showPopup; 
    // دي لما الموقع يكون لسا بيحمل استعمل الفنكشن دي 


    