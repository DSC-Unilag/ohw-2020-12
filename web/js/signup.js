window.onload = () => {
  const signupBtn = document.querySelector("#signup-button");

  function signUpUser(url) {
    const name = document.querySelector("#name").value;
    const username = document.querySelector("#username").value;
    const email = document.querySelector("#email-address").value;
    const password = document.querySelector("#password").value;

    const data = { username, password, email, name };
    fetch(url, {
      method: "POST",
      body: JSON.stringify(data),
      //   credentials: "include",
      headers: {
        Accept: "application/json, text/plain, */*",
        "Content-type": "application/json",
      },
    })
      .then((res) => res.json())
      .then((res) => {
        const { error, status } = res;
        if (error) {
          var myToast = Toastify({
            text: error,
            duration: 5000,
          });
          myToast.showToast();
        } else if (status === 200) {
          localStorage.setItem("accessToken", res.token);

          localStorage.setItem("username", data.username);
          window.location.href = "../footer/footer.html";
        }
      })
      .catch((err) => {
        console.log("Error : ", err);
      });
  }

  signupBtn.addEventListener("click", (e) => {
    e.preventDefault();
    const url = `https://recipe-saver-backend.herokuapp.com/api/v1/auth/register`;
    signUpUser(url);
  });
};
