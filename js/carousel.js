
let currentSlideIndex = 0;
const slides = document.querySelector('.carousel').children;
const totalSlides = slides.length;

function showSlide(index) {
    document.querySelector('.carousel').style.transform = `translateX(-${index * 50}%)`;
    document.querySelector('.dots .active').classList.remove('active');
    document.querySelectorAll('.dots span')[index / 2].classList.add('active');
}

function nextSlide() {
    currentSlideIndex = (currentSlideIndex + 2) % totalSlides;
    showSlide(currentSlideIndex);
}

function currentSlide(index) {
    currentSlideIndex = index;
    showSlide(currentSlideIndex);
}

setInterval(nextSlide, 3000);

function openModal(title, price, available, imgSrc) {
    document.getElementById('modalTitle').textContent = title;
    document.getElementById('modalPrice').textContent = `$ ${price}.00`;
    // document.getElementById('modalAvailable').textContent = `Available: ${available}`;
    document.getElementById('modalImg').src = imgSrc;
    document.getElementById('myModal').style.display = "block";
}

function closeModal() {
    document.getElementById('myModal').style.display = "none";
}

window.onclick = function(event) {
    const modal = document.getElementById('myModal');
    if (event.target === modal) {
        modal.style.display = "none";
    }
}