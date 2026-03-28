document.addEventListener('DOMContentLoaded', function() {
    const loginForm = document.getElementById('login-form');
    const message = document.getElementById('login-message');

    if (loginForm) {
        loginForm.addEventListener('submit', function(e) {
            e.preventDefault(); // Stops page from refreshing

            const user = document.getElementById('username').value;
            const pass = document.getElementById('password').value;

            if (user === "admin" && pass === "123") {
                // 1. Success Message
                message.style.color = "green";
                message.innerHTML = " Login Successful! <br><a href='index.html' style='color:blue; font-weight:bold;'>Click here if not redirected...</a>";

                // 2. Save session (to show user is logged in on home page)
                localStorage.setItem('username', user);

                // 3. Redirect after 1.5 seconds
                setTimeout(function() {
                    window.location.href = "index.html";
                }, 1500);

            } else {
                // Error Message
                message.style.color = "red";
                message.innerHTML = " Invalid Username or Password.";
            }
        });
    }
});
