$(document).ready(function(){
    
   //common
   //btn top
   $(".btn_top").click(function(){
        $("body, html").stop().animate({"scrollTop":0},300);
        
        return false;
    });

    
    $(window).scroll(function(){
        winH=$(window).height();
        sct=$(window).scrollTop();
        //nav
        if(sct>=121){
            $(".wrap_nav").addClass("fix");
        }else{
            $(".wrap_nav").removeClass("fix");
        }
        
        //top
        if(sct>=winH/2){
            $(".btn_top").fadeIn(500);
        } else{
            $(".btn_top").fadeOut(500);
        }

        //브랜드 스토리
        if(sct>=700){
            $(".brand_story").addClass("action");
        }
        
    });
   
    //배너 슬라이드(slick slider)
    $(".section_banner").slick({
        autoplay:true,
        autoplayspeed:2000,
        dots:true,
        fade:true
    });
    $(".slick_list").slick({
        infinite: true,
        slidesToShow: 3,
        autoplay:true,
        autoplayspeed:2000,
        dots:true
    });
    
    //상품 리스트
    $(".link_filter").click(function(){
		$(".link_filter").removeClass("on");
		$(this).addClass("on");
	});

    //관리자 탭메뉴
    /*
    $(".link_gnb").click(function(){
		$(".link_gnb").removeClass("on");
		$(this).addClass("on");
	});
	
	$(".manage_client").click(function(){
		$(".admin_cont").hide();
		$(".admin_member").show();
	});
	
	$(".manage_product").click(function(){
		$(".admin_cont").hide();
		$(".admin_product").show();
	});
	
	$(".manage_delivery").click(function(){
		$(".admin_cont").hide();
		$(".admin_delivery").show();
	});
	*/
	$(".btn_add_product").click(function(){
		$(".add_product").fadeIn(500);
	});
	$(".add_product .btn_close").click(function(){
		$(".add_product").fadeOut(500);
	});


}); 

