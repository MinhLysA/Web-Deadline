window.addEventListener("scroll", function () {
  let header = document.querySelector("header");
  if (window.scrollY > 50) {
    header.classList.add("scrolled");
  } else {
    header.classList.remove("scrolled");
  }
});

// Slider hình ảnh chính
let index = 0;

function moveSlide(step) {
  const slides = document.querySelector(".slider-images");
  const totalSlides = document.querySelectorAll(".slider-image").length;

  index = (index + step + totalSlides) % totalSlides;
  slides.style.transform = `translateX(-${index * 100}%)`;
}

// Slider bài viết phổ biến
let currentIndex = 0;
let isSliding = false;

function setupPopularSlider() {
  const slider = document.querySelector(".popular-track");
  const items = document.querySelectorAll(".popular-item");
  const firstClone = items[0].cloneNode(true);
  const lastClone = items[items.length - 1].cloneNode(true);

  slider.insertBefore(lastClone, items[0]);
  slider.appendChild(firstClone);
  slider.style.transform = `translateX(-${currentIndex * 50}%)`;
}

function slideMove(direction) {
  if (isSliding) return;
  isSliding = true;

  const slider = document.querySelector(".popular-track");
  const totalItems = document.querySelectorAll(".popular-item").length;
  const visibleItems = window.innerWidth > 768 ? 2 : 1;

  currentIndex += direction;
  slider.style.transition = "transform 0.5s ease-in-out";
  slider.style.transform = `translateX(-${
    currentIndex * (100 / visibleItems)
  }%)`;

  setTimeout(() => {
    if (currentIndex <= -1) {
      slider.style.transition = "none";
      currentIndex = totalItems - 3;
      slider.style.transform = `translateX(-${
        currentIndex * (100 / visibleItems)
      }%)`;
    } else if (currentIndex >= totalItems - 2) {
      slider.style.transition = "none";
      currentIndex = 0;
      slider.style.transform = `translateX(-${
        currentIndex * (100 / visibleItems)
      }%)`;
    }
    isSliding = false;
  }, 500);
}

document.addEventListener("DOMContentLoaded", setupPopularSlider);
