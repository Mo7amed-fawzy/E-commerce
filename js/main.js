let currentIndex = 0; 
const slides = document.querySelectorAll('.slide'); // بحط كلاس سلايد بتاعي فمتغير اسمه سلايدز
const dots = document.querySelectorAll('.dotat');  // بحط كلاس دوت بتاعي فمتغير اسمه دوتس

// كونست مينفعش تعيد تعيينهم ولكن تقدر تغير محتواهم

function showSlide(index) { // دا الباراميتر الهياخد قيمة الاندكس
    slides.forEach((slide, i) => { // هتمشي علي كل قيم سلايد بالايتيراتور
        slide.classList.toggle('active', i === index);
// classList بتخليني اتحكم فالكلاسس علي العناصر html attribut هي وجايه من dom Document Object Model

//toggle فنكشن بتستخدم عشان اضيف او اشيل كلاس ميعن بناء علي شرط معين

    }) ;
    dots.forEach((dot, i) => {
        dot.classList.toggle('active', i === index);
    });
}

function nextSlide() {
    currentIndex = (currentIndex + 1) % slides.length;
    //هذه العملية تضمن أن الاندكس الحالي يلتف مرة أخرى إلى الصفر بعد الوصول إلى آخر شريحة.
    showSlide(currentIndex);
}

dots.forEach((dot, index) => { // دا عشان لما ادوس انا علي النقطه
    dot.addEventListener('click', () => {
        currentIndex = index; // عملنا متغير سميناه اندكس وحطينا فيه قيمة السلايد الحالي
        showSlide(index); // هنا استعملت الفنكشن// 
    });
});

setInterval(nextSlide, 3000); // الفنكشن بتاخد فنكشن ومده عشان تنفذ

// خلصنا كدا حتة السويتش مبين الصور





// هنا الحته بتاعت التايمر

// Set the date we're counting down to
var countDownDate = new Date("Jan 5, 2030 15:37:25").getTime();// دي بتحول التاريخ لعدد من الملي سكند

// Update the count down every 1 second
var x = setInterval(function() { // دي فنكشن بتكرر فنكشن بشكل لا نهائي لحد متخلص setInterval الفاصل الزمني

  // Get today's date and time
  var now = new Date().getTime();
    
  // Find the distance between now and the count down date
  var distance = countDownDate - now;
    
  // Time calculations for days, hours, minutes and seconds
  var days = Math.floor(distance / (1000 * 60 * 60 * 24)); // بحسب عدد الملي ثانيه في يوم كامل 
  var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
  var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
  var seconds = Math.floor((distance % (1000 * 60)) / 1000);
    
  // Output the result in individual elements
  document.getElementById("days").innerHTML = days + "d"; // دي طريقة عشان تغير من المحتوي الف html 
  document.getElementById("hours").innerHTML = hours + "h";
  document.getElementById("minutes").innerHTML = minutes + "m";
  document.getElementById("seconds").innerHTML = seconds + "s";
    
  // If the count down is over, write some text 
  if (distance < 0) {
    clearInterval(x);
    document.getElementById("timer").innerHTML = "EXPIRED";
  }
}, 1000);




window.addEventListener('scroll', () => {
    const scrollButton = document.getElementById('backtotop');
    // if (window.scrollY > 150) {
    //     scrollButton.classList.add('show'); 
    // } else {
    //     scrollButton.classList.remove('show');
    // }

    // short-term conditional باستخدام
    window.scrollY > 150 ? scrollButton.classList.add('show') : scrollButton.classList.remove('show');
}
);

document.getElementById('backtotop').addEventListener('click', () => {
    window.scrollTo({
        top: 0,
        behavior: 'smooth' // دي طريقة الرجوع تكون سلسله
    });
});
document.getElementById('backtotoptow').addEventListener('click', () => {
    window.scrollTo({
        top: 0,
        behavior: 'smooth'
    });
});


  const Onsearch = () => {
            const input = document.getElementById("search");
            const filter = input.value.toUpperCase();
    
            const list = document.querySelectorAll("#dropdown-menu .dropdown-item");
    
            list.forEach((ahmed) => { // تبع typescript وليست دي بتشير لنوع البيانات
                const text = ahmed.textContent.toUpperCase();
                
                // if (text.includes(filter)) {
                    //     ahmed.style.display = ""; 
                    // } else {
                    //     ahmed.style.display = "none"; 
                    // }
                    
                ahmed.style.display = text.includes(filter) ? "" : "none";
                
                    });
        }
        
        // Add event listener to the input to trigger the search function
        document.getElementById("search").addEventListener("input", Onsearch);