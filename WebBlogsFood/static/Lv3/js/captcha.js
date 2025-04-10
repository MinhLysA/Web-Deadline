document.addEventListener("DOMContentLoaded", function () {
  const form = document.querySelector(".register-form");
  const captchaCheckbox = document.getElementById("captcha-checkbox");
  const captchaError = document.getElementById("captcha-error");

  form.addEventListener("submit", function (event) {
    if (!captchaCheckbox.checked) {
      event.preventDefault();
      captchaError.textContent = "Vui lòng xác nhận bạn không phải là robot.";
    } else {
      captchaError.textContent = "";
    }
  });
});
