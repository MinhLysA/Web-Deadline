window.addEventListener("scroll", function () {
  let header = document.querySelector("header");
  if (window.scrollY > 50) {
    // Nếu cuộn xuống hơn 50px
    header.classList.add("scrolled");
  } else {
    header.classList.remove("scrolled");
  }
});
let index = 0;

function moveSlide(step) {
  const slides = document.querySelector(".slides");
  const totalSlides = document.querySelectorAll(".slide").length;

  index = (index + step + totalSlides) % totalSlides;
  slides.style.transform = `translateX(-${index * 100}%)`;
}
let currentIndex = 2; // Bắt đầu từ phần tử thứ 2 để tạo vòng lặp mượt
let isSliding = false;

function setupSlider() {
  const slider = document.querySelector(".slider-track");
  const items = document.querySelectorAll(".slider-item");
  const firstClone = items[0].cloneNode(true);
  const lastClone = items[items.length - 1].cloneNode(true);

  slider.insertBefore(lastClone, items[0]); // Chèn bản sao cuối lên đầu
  slider.appendChild(firstClone); // Chèn bản sao đầu xuống cuối
  slider.style.transform = `translateX(-${currentIndex * 50}%)`;
}

function slideMove(direction) {
  if (isSliding) return; // Ngăn spam click khi đang chuyển động
  isSliding = true;

  const slider = document.querySelector(".slider-track");
  const totalItems = document.querySelectorAll(".slider-item").length;
  const visibleItems = window.innerWidth > 768 ? 2 : 1;

  currentIndex += direction;
  slider.style.transition = "transform 0.5s ease-in-out";
  slider.style.transform = `translateX(-${
    currentIndex * (100 / visibleItems)
  }%)`;

  setTimeout(() => {
    if (currentIndex <= 0) {
      slider.style.transition = "none";
      currentIndex = totalItems - 2; // Quay về bản sao cuối
      slider.style.transform = `translateX(-${
        currentIndex * (100 / visibleItems)
      }%)`;
    } else if (currentIndex >= totalItems - 1) {
      slider.style.transition = "none";
      currentIndex = 1; // Quay về bản sao đầu
      slider.style.transform = `translateX(-${
        currentIndex * (100 / visibleItems)
      }%)`;
    }
    isSliding = false;
  }, 500);
}

document.addEventListener("DOMContentLoaded", setupSlider);
