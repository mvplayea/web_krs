<script>
  function goToLogin() {
    window.location.href = '/login';
  }
</script>

<section>
  <p class="welcome-text">SELAMAT DATANG DI</p>
  <div class="container">
    <div class="content">
      <div class="text-section">
        <h1>PORTAL</h1>
        <h2>MAHASISWA</h2>
        <p>
          Portal ini memudahkan mahasiswa dalam mengakses sistem KRS kampus dengan satu kali
          autentikasi. Silakan masukkan Username dan Password Anda untuk melanjutkan, dan nikmati
          pengalaman digital yang lebih praktis dan terintegrasi.
        </p>
      </div>
      <div class="image-section">
        <img
          src="https://images.pexels.com/photos/8106659/pexels-photo-8106659.jpeg"
          alt="Graduation Celebration"
        />
      </div>
    </div>
    <div class="button-section">
      <a href="/login">
        <button class="masuk-button">MASUK</button>
      </a>
    </div>
  </div>
  <hr/>
  <div class="news">
    <h1>BERITA TERBARU</h1>
    <div class="img-gallery">
      <img
        src="https://images.pexels.com/photos/2982449/pexels-photo-2982449.jpeg"
        alt="Campus"
      />
      <img
        src="https://images.pexels.com/photos/5554236/pexels-photo-5554236.jpeg"
        alt="Relation"
      />
      <img src="https://images.pexels.com/photos/256455/pexels-photo-256455.jpeg" alt="Library"/>
    </div>
  </div>
</section>

<style>
  * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: Arial, sans-serif;
  }
  
  body {
    padding-top: 20px;
    background-color: #763497;
    font-size: 1rem;
  }
  
  .welcome-text {
    text-align: left;
    margin-left: 95px;
    font-size: 1.5rem;
    color: #D9D9D9;
    margin-bottom: 15px;
  }
  
  .container {
    width: 100%;
    max-width: 1100px;
    height: 500px;
    margin: 0 auto;
    background-color: #f4f4f4;
    border-radius: 15px;
    border: solid;
    padding: 30px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  }
  
  .content {
    display: flex;
    align-items: center;
    justify-content: space-between;
  }
  
  .text-section {
    max-width: 50%;
  }
  
  .text-section h1 {
    font-size: 3rem;
    font-weight: 900;
    margin-bottom: 20px;
    margin-left: 20px;
    color: #000;
  }
  
  .text-section h2 {
    font-size: 3rem;
    font-weight: 900;
    margin-bottom: 40px;
    margin-left: 10px;
    color: #000;
    position: relative;
    z-index: 1;
    padding: 10px;
    display: inline-block;
  }
  
  .text-section h2::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: #C2C8DA;
    z-index: -1;
    transform: rotate(-3deg);
    transform-origin: left bottom;
    padding: 10px;
    width: 100%;
    height: 100%;
    margin: -10px;
    
  }
  
  .text-section p {
    color: #000;
    font-size: 1rem;
    line-height: 1.5;
    margin-left: 20px;
  }
  
  .image-section img {
    width: 470px;
    height: 466px;
  }
  
  .button-section {
    text-align: right;
    margin-top: 20px;
  }
  
  .masuk-button {
    background-color: #D9D9D9;
    color:#000000;
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    font-size: 1rem;
    cursor: pointer;
    transition: background-color 0.3s;
    position: absolute;
    top: 15px;
    right: 80px;
  }
  
  .masuk-button:hover {
    background-color: #555;
  }
  
  hr {
    background-color: #D9D9D9;
    border: none;
    height: 60px;
    width: 100%;
    margin: 20px auto;
  }
  
  .news {
    text-align: left;
    margin-top:2px;
  }
  
  .news h1 {
    font-size: 1.5rem;
    font-weight: 900;
    margin-bottom: 20px;
    margin-left: 85px;
    color: #000;
  }
  
  .img-gallery {
    display: flex;
    justify-content: center;
    gap: 70px;
    margin-bottom: 50px;
  }
  
  .img-gallery img {
    width: 320px;
    height: 250px;
    border-radius: 10px;
    object-fit: cover;
  }
  
  @media (max-width: 100px) {
    .content {
      flex-direction: column;
      align-items: flex-start;
    }
    
    .text-section {
      max-width: 100%;
      text-align: left;
      margin-left: 0;
    }
    
    .image-section {
      max-width: 100%;
      text-align: right;
      margin-left: 1rem;
    }
    
    .image-section img {
      max-width: 100%;
      height: 100px;
    }
    
    .welcome-text {
      text-align: left;
      margin-left: 0;
    }
    
    .masuk-button {
      top: 10px;
      right: 10px;
      padding: 8px 16px;
    }
  }
</style>
