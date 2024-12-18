<script>
  let {children} = $props();
</script>

<style>
  section {
    display: flex;
    width: 100%;
  }
  .sidebar {
    background-color: #007bff; /* Blue background */
    color: white;
    min-height: 100vh;
    padding: 2em;
    box-sizing: border-box;
  }
  
  .sidebar a {
    display: flex;
    align-items: center;
    gap: 10px;
    text-decoration: none;
    color: white;
    font-size: 16px;
    padding: 10px;
    border-radius: 4px;
    margin-bottom: 10px;
    transition: background-color 0.3s ease, transform 0.3s ease;
  }
  
  .sidebar a:hover {
    background-color: #0056b3; /* Darker blue on hover */
    transform: scale(1.05);
  }
  
  .sidebar a:active {
    transform: scale(1);
  }
  
  .icon {
    width: 20px;
    height: 20px;
    background-color: white; /* Placeholder for the icon */
    border-radius: 4px;
  }
  
  .content {
    padding: 20px;
  }
</style>

<section>
  <div class="sidebar">
    <a href="/admin/mahasiswa">
      Mahasiswa
    </a>
    <a href="/admin/matakuliah">
      Mata Kuliah
    </a>
    <a href="/admin/matakuliah">
      Prodi
    </a>
    <a href="/admin/matakuliah">
      Jurusan
    </a>
  </div>
  <div class="content">
    {@render children()}
  </div>
</section>
