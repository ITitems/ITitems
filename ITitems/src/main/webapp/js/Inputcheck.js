/* ********************************************************
 * 특수문자 확인(특수문자 전부 제거)
 ******************************************************** */
function symbolCheck1(obj){
	let val = $(obj).val();
	let newVal = val.replace(/[^a-zA-Z0-9ㄱ-ㅎㅏ-ㅣ가-힣]/g, "");
	 $(obj).val(newVal);
}

/* ********************************************************
 * 특수문자 확인(-_.만 허용)
 ******************************************************** */
function symbolCheck2(obj){
	let val = $(obj).val();
	let newVal = val.replace(/[^a-zA-Z0-9ㄱ-ㅎㅏ-ㅣ가-힣-_.]/g, "");
	 $(obj).val(newVal);
}

/* ********************************************************
 * 숫자 콤마 입력
 ******************************************************** */
 function getNumber(obj){
     var num01;
     var num02;
     num01 = $(obj).val();
     if(num01 != null && num01 != ""){
    	num02 = num01.replace(/(^0+)/, "");
	    num03 = num02.replace(/\D/g,"");
	    num01 = setComma(num03);
	    obj.value =  num01;
     }
     
  }

  function setComma(n) {
     var reg = /(^[+-]?\d+)(\d{3})/;
     n += '';         
     while (reg.test(n)) {
        n = n.replace(reg, '$1' + ',' + '$2');
     }         
     return n;
  }

/* ********************************************************
 * 최대 수량 입력 (100개제한)
 ******************************************************** */
function checkQty(obj){
	removeP(obj);
	let td = $(obj).closest("td");
	var num01 = $(obj).val();
	if(num01 != null && num01 != ""){
    	num01 = num01.replace(/(^0+)/, "");
	    num01 = num01.replace(/\D/g,"");
     }
	if(num01 > 100){
		$(td).append($('<p/>').addClass('alertV').text("최대 100개까지 입력가능합니다"));
		$(obj).val('100');
	}else{
		$(obj).val(num01);
	}
}

function removeP(obj) {
	let td = $(obj).closest("td");
	if($(td).children().last().prop('tagName') == 'P'){
		$(td).children().last().remove();
	}
}
