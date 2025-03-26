window.onscroll = function() {myFunction()};

var header = document.getElementById("myHeader");
var sticky = header.offsetTop;
var headerTexts = document.getElementsByClassName("header-text"); // Lấy tất cả phần tử có class "header-text"

function myFunction() {
    if (window.pageYOffset > sticky) {
        header.style.backgroundColor = "red";
        for (var i = 0; i < headerTexts.length; i++) { // Duyệt qua tất cả phần tử có class "header-text"
            headerTexts[i].style.color = "white"; // Thay đổi màu chữ thành trắng
        }
    } else {
        header.style.backgroundColor = "#f0f0f0";
        for (var i = 0; i < headerTexts.length; i++) {
            headerTexts[i].style.color = ""; // Đặt lại màu chữ về mặc định (hoặc bạn có thể đặt màu cụ thể)
        }
    }
}