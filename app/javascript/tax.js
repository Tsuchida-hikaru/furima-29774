function tax_calc(){
  let price_element = document.getElementById("item-price");
  price_element.addEventListener('input', () => {
    let price = document.getElementById("item-price").value;
    let tax_price = price / 10;
    let tax_price_int = parseInt(tax_price, 10);
    let profit = parseInt(price - tax_price_int, 10);
    const tax_price_field = document.getElementById("add-tax-price");
    const profit_field = document.getElementById("profit");
    tax_price_field.innerHTML = tax_price_int;
    profit_field.innerHTML = profit;
  });
}

if(document.URL.match('/products/new', '/products/.*/edit')){
  window.addEventListener("load", tax_calc);
}
