<script>
  import axios from 'axios';
  import {loginUser} from "$lib/util.js";
  
  // @ts-ignore
  let username;
  // @ts-ignore
  let password;
  
  const handleLogin = async () => {
    try {
      if (username.toLowerCase() && password.toLowerCase() === 'admin1' || username.toLowerCase() && password.toLowerCase() === 'admin2'){
        window.location = '/admin';
        return
      }
      const resp = await axios.post('/api/login', {
        // @ts-ignore
        username,
        // @ts-ignore
        password,
      });
      
      if (resp.data.mahasiswa.length > 0) {
        loginUser(localStorage, resp.data.mahasiswa[0]);
        window.location = "/dashboard/beranda";
      }
    } catch (error) {
      console.error(error);
      alert('Login gagal, coba lagi')
    }
  };
  
  const showResetPasswordAlert = () => {
    alert('Isi sesuai NIM anda');
  };
</script>

<section id="login_section">
  <h1>LOGIN</h1>
  <div class="container">
    <div class="form-title">FORM MASUK</div>
    <form>
      <div class="form-row">
        <div class="form-group">
          <label for="username">Username/NIM</label>
          <input type="text" id="username" name="username" bind:value={username}/>
        </div>
        <div class="form-group">
          <label for="password">Password</label>
          <input type="password" id="password" name="password" bind:value={password}/>
        </div>
      </div>
      <div class="form-group">
        <button onclick={handleLogin} type="submit">Login</button>
      </div>
    </form>
    <div class="forgot-password" onclick={showResetPasswordAlert}>
      <p><a href="#" class="forgot-password-link">Lupa password?</a></p>
    </div>
  </div>
</section>

<style>
  /*#login_section {*/
  /*	font-family: sans-serif;*/
  /*	margin: 0;*/
  /*	height: 100vh;*/
  /*	display: flex;*/
  /*	justify-content: center;*/
  /*	align-items: center;*/
  /*	position: relative;*/
  /*}*/
  
  /*#login_section::before {*/
  /*	content: '';*/
  /*	position: absolute;*/
  /*	top: 0;*/
  /*	left: 0;*/
  /*	width: 100%;*/
  /*	height: 100%;*/
  /*	background-color: #272829;*/
  /*	background-position: center;*/
  /*	z-index: -1;*/
  /*}*/
  
  /*h1 {*/
  /*	font-size: 5.2rem;*/
  /*	color: #686d76;*/
  /*	font-weight: 800;*/
  /*	display: flex;*/
  /*	flex-direction: column;*/
  /*	writing-mode: vertical-rl;*/
  /*	text-orientation: upright;*/
  /*	!* margin-left: 300px; *!*/
  /*	position: absolute;*/
  /*	left: -50px;*/
  /*	transform-origin: translateY(-50%);*/
  /*}*/
  
  /*.container {*/
  /*	background-color: #eaeaea;*/
  /*	padding: 40px 30px;*/
  /*	border-radius: 10px;*/
  /*	border: solid;*/
  /*	box-shadow: 0px 8px 15px rgba(0, 0, 0, 0.2);*/
  /*	width: 500px;*/
  /*	height: 450px;*/
  /*	text-align: left;*/
  /*	margin-left: 150px;*/
  /*}*/
  
  /*.form-title {*/
  /*	font-size: 1.2rem;*/
  /*	font-weight: 800;*/
  /*	color: #000;*/
  /*	margin-bottom: 20px;*/
  /*	text-align: left;*/
  /*}*/
  
  /*.form-row {*/
  /*	display: block;*/
  /*	margin-bottom: 20px;*/
  /*}*/
  
  /*.form-group {*/
  /*	text-align: left;*/
  /*	margin-bottom: 35px;*/
  /*}*/
  
  /*.form-group button {*/
  /*	display: block;*/
  /*	font-weight: normal;*/
  /*	color: #000;*/
  /*	margin-bottom: 10px;*/
  /*	font-size: 1rem;*/
  /*}*/
  
  /*.form-group input[type='text'],*/
  /*.form-group input[type='password'] {*/
  /*	width: 100%;*/
  /*	padding: 15px;*/
  /*	border-radius: 10px;*/
  /*	border: none;*/
  /*	font-size: 1rem;*/
  /*	box-sizing: border-box;*/
  /*	outline: none;*/
  /*	background-color: #fff;*/
  /*}*/
  
  /*.forgot-password {*/
  /*	width: 100%;*/
  /*	padding: 10px;*/
  /*	border-radius: 5px;*/
  /*	border: none;*/
  /*	font-size: 1rem;*/
  /*	box-sizing: border-box;*/
  /*	outline: none;*/
  /*	background-color: #fff;*/
  /*}*/
  
  /*.forgot-password-link {*/
  /*	color: inherit;*/
  /*	text-decoration: none;*/
  /*	font-weight: bold;*/
  /*}*/
  
  /*.forgot-password-link:hover {*/
  /*	color: #007bff;*/
  /*	text-decoration: underline;*/
  /*}*/
  
  /*.form-group input[type='submit'] {*/
  /*	background-color: #272829;*/
  /*	color: white;*/
  /*	width: 100%;*/
  /*	padding: 10px 20px;*/
  /*	margin-bottom: 10px;*/
  /*	border: none;*/
  /*	border-radius: 10px;*/
  /*	font-size: 1rem;*/
  /*	cursor: pointer;*/
  /*}*/
  
  /*@media (max-width: 768px) {*/
  /*	h1 {*/
  /*		font-size: 3.2rem;*/
  /*		left: 5px;*/
  /*	}*/
  
  /*	.container {*/
  /*		margin-left: 0;*/
  /*		padding: 30px 20px;*/
  /*		width: 80%;*/
  /*	}*/
  
  /*	.form-title {*/
  /*		font-size: 1.1rem;*/
  /*	}*/
  
  /*	.form-group input[type='text'],*/
  /*	.form-group input[type='password'] {*/
  /*		padding: 12px;*/
  /*	}*/
  
  /*	.form-group input[type='submit'] {*/
  /*		padding: 12px;*/
  /*	}*/
  /*}*/
  
  /*@media (max-width: 480px) {*/
  /*	h1 {*/
  /*		text-align: left;*/
  /*	}*/
  /*	.container {*/
  /*		width: 90%;*/
  /*		padding: 20px;*/
  /*	}*/
  
  /*	.form-title {*/
  /*		font-size: 1rem;*/
  /*		text-align: center;*/
  /*	}*/
  
  /*	.forgot-password {*/
  /*		text-align: center;*/
  /*	}*/
  
  /*	.forgot-password-link,*/
  /*	.form-group label,*/
  /*	.form-group input[type='text'],*/
  /*	.form-group input[type='password'],*/
  /*	.form-group input[type='submit'] {*/
  /*		font-size: 0.9rem;*/
  /*	}*/
  /*}*/
  section {
    font-family: sans-serif;
    margin: 0;
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    position: relative;
  }
  
  body::before {
    content: "";
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: #D9D9D9;
    background-position: center;
    z-index: -1;
  }
  
  h1 {
    font-size: 5.2rem;
    color: #97989b;
    font-weight: 800;
    display: flex;
    flex-direction: column;
    writing-mode: vertical-rl;
    text-orientation: upright;
    margin-left: 300px;
    position: absolute;
    left: 5px;
    transform-origin: translateY(-50%);
  }
  
  .container {
    background-color: #763497;
    padding: 40px 30px;
    border-radius: 10px;
    box-shadow: 0px 8px 15px rgba(0, 0, 0, 0.2);
    width: 500px;
    height: 450px;
    text-align: left;
    margin-left: 150px;
  }
  
  .form-title {
    font-size: 1.2rem;
    font-weight: 800;
    color: #FFFFFF;
    margin-bottom: 20px;
    text-align: left;
  }
  
  .form-row {
    display: block;
    margin-bottom: 20px;
  }
  
  .form-group {
    text-align: left;
    margin-bottom: 35px;
  }
  
  .form-group label {
    display: block;
    font-weight: normal;
    color: #FFFFFF;
    margin-bottom: 10px;
    font-size: 1rem;
  }
  
  .form-group input[type="text"],
  .form-group input[type="password"] {
    width: 100%;
    padding: 15px;
    border-radius: 10px;
    border: none;
    font-size: 1rem;
    box-sizing: border-box;
    outline: none;
    background-color: #fff;
  }
  
  .form-group button[type="submit"] {
    background-color: #272829;
    color: white;
    width: 100%;
    padding: 10px 20px;
    margin-bottom: 10px;
    border: none;
    border-radius: 10px;
    font-size: 1rem;
    cursor: pointer;
  }
  
  .forgot-password {
    width: 100%;
    padding: 10px;
    border-radius: 5px;
    border: none;
    font-size: 1rem;
    box-sizing: border-box;
    outline: none;
    background-color: #fff;
  }
  
  .forgot-password-link {
    color: inherit;
    text-decoration: none;
    font-weight: bold;
    font-size: 20px;
  }
  
  .forgot-password-link:hover {
    color: #007BFF;
    text-decoration: underline;
  }
  
  
  .form-group input[type="submit"] {
    background-color: #272829;
    color: white;
    width: 100%;
    padding: 10px 20px;
    margin-bottom: 10px;
    border: none;
    border-radius: 10px;
    font-size: 1rem;
    cursor: pointer;
  }
  
  @media (max-width: 768px) {
    h1 {
      display: none;
    }
    
    .container {
      margin-left: 0;
      padding: 30px 20px;
      width: 80%;
    }
    
    .form-title {
      font-size: 1.1rem;
    }
    
    .form-group input[type="text"],
    .form-group input[type="password"] {
      padding: 12px;
    }
    
    .form-group input[type="submit"] {
      padding: 12px;
    }
  }
  
  @media (max-width: 480px) {
    h1 {
      text-align: left;
    }
    
    .container {
      width: 90%;
      padding: 20px;
    }
    
    .form-title {
      font-size: 1rem;
      text-align: center;
    }
    
    .forgot-password {
      text-align: center;
    }
    
    .forgot-password-link,
    .form-group label,
    .form-group input[type="text"],
    .form-group input[type="password"],
    .form-group input[type="submit"] {
      font-size: 0.9rem;
    }
  }
</style>
