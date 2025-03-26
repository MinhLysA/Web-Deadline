document.addEventListener("DOMContentLoaded", function () {
  const slides = document.querySelector(".slides");
  const slideItems = document.querySelectorAll(".slide");
  const totalSlides = slideItems.length; // Số lượng slide
  let currentIndex = 0;

  function updateSlide() {
    slides.style.transform = `translateX(-${currentIndex * 100}%)`; // Mỗi lần di chuyển 100% vì mỗi slide chiếm toàn bộ chiều rộng
  }

  document.querySelector(".next").addEventListener("click", function () {
    currentIndex = (currentIndex + 1) % totalSlides;
    updateSlide();
  });

  document.querySelector(".prev").addEventListener("click", function () {
    currentIndex = (currentIndex - 1 + totalSlides) % totalSlides;
    updateSlide();
  });
});
