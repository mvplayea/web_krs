<div class="container">
  <div class="image-container">
    <img src="images/logo.jpg" alt="Logo">
  </div>
  <h1><span class="black-text">KARTU RENCANA </span><br><span class="white-text">STUDI MAHASISWA</span></h1>
</div>

<style>
  .container {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: row;
    min-height: calc(100vh - 60px);
    padding-top: 100px;
    text-align: center;
    box-sizing: border-box;
    flex-wrap: wrap;
  }
  
  .image-container {
    width: 210px;
    height: 200px;
    margin-right: 50px;
  }
  
  .image-container img {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }
  
  h1 {
    font-size: 3rem;
    font-weight: bold;
    margin-top: 10px;
    line-height: 1.5;
    color: #000000;
    text-shadow: 2px 2px 6px rgba(0, 0, 0, 0.15);
  }
  
  .black-text {
    color: #000000;
  }
  
  .white-text {
    color: #ffffff;
  }
  
  /* Responsive Styles */
  @media (max-width: 768px) {
    .top-bar .nav {
      gap: 15px;
    }
    
    .top-bar .nav a {
      font-size: 0.9rem;
      padding: 6px 10px;
    }
    
    .top-bar .exit-button {
      padding: 6px 12px;
      font-size: 0.8rem;
    }
    
    .container {
      flex-direction: column;
      padding-top: 50px;
    }
    
    .image-container {
      width: 180px;
      height: 180px;
      margin-bottom: 20px;
    }
    
    h1 {
      font-size: 2rem;
      text-align: center;
    }
  }
  
  @media (max-width: 480px) {
    .top-bar .logo {
      font-size: 1.2rem;
    }
    
    .top-bar .nav {
      flex-direction: column;
      gap: 10px;
    }
    
    .top-bar .nav a {
      font-size: 0.8rem;
      padding: 5px 10px;
    }
    
    .top-bar .exit-button {
      padding: 5px 10px;
      font-size: 0.7rem;
    }
    
    .container {
      padding-top: 30px;
    }
    
    .image-container {
      width: 150px;
      height: 150px;
      margin-bottom: 15px;
    }
    
    h1 {
      font-size: 1.5rem;
    }
  }
</style>
