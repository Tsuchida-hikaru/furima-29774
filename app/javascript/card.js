const pay = () => {
  Payjp.setPublickey("pk_test_0f8ad49e078d6be80dafaafc");
  const form = document.getElementById("charge-form")
  form.addEventListener("submit", (e) => {
    e.preventDefault();
    console.log("フォーム創始神事にいえんべてゃっ￥はっかa")
  });
};

window.addEventListener("load", pay);
