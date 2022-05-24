// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on('click', '.dec-btn', function() {
    var itemId = $(this).attr('data-item-id');
    var qtyElem = $('#quantity-item-' + itemId);
    var qty = parseInt(qtyElem.html());
    if (qty != 1) {
        qty--;
        qtyElem.html(qty);
        $('#quantity-' + itemId).val(qty);
    }
    if (qty == 1)
        $(this).prop('disabled', true);
});
$(document).on('click', '.inc-btn', function() {
    var itemId = $(this).attr('data-item-id');
    var qtyElem = $('#quantity-item-' + itemId);
    var qty = parseInt(qtyElem.html());
    qty++;
    qtyElem.html(qty);
    $('#dec-btn-item-' + itemId).prop('disabled', false)
    $('#quantity-' + itemId).val(qty);
})