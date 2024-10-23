document.querySelector(".item_view_photo").addEventListener("click",function(){ // 모달창 on
    document.querySelector(".background_modal").classList.add("on");
});
document.querySelector(".photo_modal_title_close").addEventListener("click",function(){ // 모달창 off
    document.querySelector(".background_modal").classList.remove("on");
});

var modal_img=document.querySelector(".item_view_photo").innerHTML; // 상세 이미지
document.querySelector(".photo_modal_list_zoom").innerHTML=modal_img; // 모달 이미지
var modal_title=document.querySelector(".item_detail_title").innerHTML; // 상세 제목
document.querySelector(".photo_modal_title_info").innerHTML=modal_title; // 모달 제목
var plusbtn=document.querySelector(".goods_detail_cnts_plus"); // 더보기 버튼
var plusScreen=document.querySelector(".goods_detail_cnts"); // 더보기 스크린 부분

plusbtn.addEventListener("click", function(){
    if(plusScreen.className=="goods_detail_cnts on" ){
        plusScreen.classList.remove("on");
        plusbtn.innerHTML="상세정보 더보기";
    }else{
        plusScreen.classList.add("on");
        plusbtn.innerHTML="상세정보 접기";
    }
});

/*document.querySelector(".goods_reviews_wrt").addEventListener("click",function(){	// 상품후기작성 on
	document.querySelector(".background_review_writer").classList.add("on");
});*/
/*document.querySelector(".review_cencel").addEventListener("click",function(){	// 상품후기작성 off
	document.querySelector(".background_review_writer").classList.remove("on");
});*/