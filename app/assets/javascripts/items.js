// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on('click', '.cart-item-dec', function() {
    var qtyElemId = $(this).attr('data-cart-item-id')
    var qtyElem = $('#quantity-cart-' + qtyElemId);
    var qty = parseInt(qtyElem.html());
    if (qty != 1) {
        qty--;
        qtyElem.html(qty);
        $('quantity-' + qtyElemId).val(qty);
    }
});

$(document).on('click', '.cart-item-inc', function() {
    var qtyElemId = $(this).attr('data-cart-item-id')
    var qtyElem = $('#quantity-cart-' + qtyElemId);
    var qty = parseInt(qtyElem.html());
    qty++;
    qtyElem.html(qty);
    $('quantity-' + qtyElemId).val(qty);
    $.ajax({
        type: "PUT",
        contentType: "application/json; charset=utf-8",
        url: "/cart_items/update",
        data: JSON.stringify({ id: qtyElemId }),
        dataType: "json",
        success: function(result) {
            //do somthing here
            console.log(success);
        },
        error: function(e) {
            console.log(e);
        }
    });
});