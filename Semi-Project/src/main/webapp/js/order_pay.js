window.onload = function() {
    // 결제 요소와 닫기 버튼 가져오기
    var modal = document.getElementById("paymentModal");
    var closeBtn = document.getElementsByClassName("close")[0];
    var orderBtn = document.getElementsByClassName("btn_order_buy")[0];

    // 결제하기 버튼 클릭 시 모달 열기
    orderBtn.onclick = function() {
        modal.style.display = "block";
    }

    // 닫기 버튼 클릭 시 모달 닫기
    closeBtn.onclick = function() {
        modal.style.display = "none";
    }

    // 모달 밖 클릭 시 모달 닫기
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
}
