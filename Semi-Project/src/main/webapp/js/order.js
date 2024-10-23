/*function toggleAddress(useDefault) {
            if (useDefault) {
                document.getElementById('recipient_name').value = "<%=loginClient.getClientName()%>";
                document.getElementById('postcode').value = "<%=loginClient.getClientZipcode()%>";
                document.getElementById('address').value = "<%=loginClient.getClientAddress1()%>";
                document.getElementById('detailAddress').value = "<%=loginClient.getClientAddress2()%>";
                document.getElementById('recipient_phone').value = "<%=loginClient.getClientMobile()%>";
	
			document.getElementById('recipient_name').readOnly = true;
			document.getElementById('postcode').readOnly = true;
			document.getElementById('address').readOnly = true;
			document.getElementById('detailAddress').readOnly = true;
			document.getElementById('recipient_phone').readOnly = true;
		} else {
			document.getElementById('recipient_name').value = "";
			document.getElementById('postcode').value = "";
			document.getElementById('address').value = "";
			document.getElementById('detailAddress').value = "";
			document.getElementById('recipient_phone').value = "";
			document.getElementById('recipient_name').readOnly = false;
			document.getElementById('postcode').readOnly = false;
			document.getElementById('address').readOnly = false;
			document.getElementById('detailAddress').readOnly = false;
			document.getElementById('recipient_phone').readOnly = false;
		}
	}
window.onload = function() {
		toggleAddress(true);
	};*/


function openPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            var postcode = data.zonecode; // 우편번호
            var address = data.address; // 기본 주소

            document.getElementById('postcode').value = postcode;
            document.getElementById('address').value = address;
            document.getElementById('detailAddress').focus();
        }
    }).open();
};


