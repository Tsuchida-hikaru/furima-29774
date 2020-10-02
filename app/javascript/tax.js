function tax_calc(){
  let price_element = document.getElementById("item-price");
  price_element.addEventListener('input', () => {
    //price = parseInt(price, 10)
    let price = document.getElementById("item-price").value;
    let tax_price = parseInt((price / 10), 10);
    let profit = parseInt(price - tax_price, 10);
    const tax_price_field = document.getElementById("add-tax-price");
    const profit_field = document.getElementById("profit");
    tax_price_field.innerHTML = tax_price;
    profit_field.innerHTML = profit;
  });
}
window.addEventListener("load", tax_calc);