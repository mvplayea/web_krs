<script>
    import axios from "axios";
    import {onMount} from "svelte";

    let prodiData;
    let semesterData;

    // IGNORE THIS API, THIS FOR OPTIONS ONLY
    async function getProdi() {
        try {
            const response = await axios.get('/api/prodi');

            prodiData = await response.data.prodi[0];
        } catch (error) {
            console.error('Error:', error);
        }
    }

    async function getSemester() {
        try {
            const response = await axios.get('/api/semester');

            semesterData = await response.data.semester[0];
        } catch (error) {
            console.error('Error:', error);
        }
    }

    let formData = {
        NIM: '',
        nama_mahasiswa: '',
        tanggallahir: '',
        agama: '',
        jenis_kelamin: '',
        alamat: '',
        kd_prodi: '',
        semester_id: ''
    };

    // CREATE API
    async function handleSubmit() {
        try {
            console.log(formData)
            const response = await axios.post('/api/mahasiswa', {
                ...formData,
            });

            // if (!response.status !== 200) {
            //   throw new Error('Network response was not ok');
            // }

            const result = await response.data;
            alert('Data submitted successfully!');

            // Reset form
            formData = {
                NIM: '',
                nama_mahasiswa: '',
                tanggallahir: '',
                agama: '',
                jenis_kelamin: '',
                alamat: '',
                kd_prodi: '',
                semester_id: ''
            };
        } catch (error) {
            console.error('Error:', error);
            alert('Failed to submit data');
        }
    }

    onMount(async () => {
        await getProdi();
        await getSemester();
    })
</script>

<section>
    <div class="main">
        <div class="form-container">
            <div class="form-header">
                + Buat Mahasiswa
            </div>
            <form class="form-body" on:submit|preventDefault={handleSubmit}>
                <div class="form-group">
                    <label for="nim">NIM</label>
                    <input
                            type="text"
                            id="nim"
                            bind:value={formData.NIM}
                    />
                </div>

                <div class="form-group">
                    <label for="nama">Nama</label>
                    <input
                            type="text"
                            id="nama_mahasiswa"
                            bind:value={formData.nama_mahasiswa}
                    />
                </div>

                <div class="form-group">
                    <label for="alamat">Alamat:</label>
                    <input
                            type="text"
                            id="alamat"
                            bind:value={formData.alamat}
                    />
                </div>

                <div class="form-group">
                    <label for="agama">Agama:</label>
                    <input
                            type="text"
                            id="agama"
                            bind:value={formData.agama}
                    />
                </div>

                <div class="form-group">
                    <label for="tanggallahir">Tanggal Lahir:</label>
                    <input
                            type="date"
                            id="tanggallahir"
                            bind:value={formData.tanggallahir}
                    />
                </div>

                <div class="form-group">
                    <label for="jenis_kelamin">Jenis Kelamin:</label>
                    <select
                            id="jenis_kelamin"
                            bind:value={formData.jenis_kelamin}
                    >
                        <option value="">Select Gender</option>
                        <option value="L">Laki-laki</option>
                        <option value="P">Perempuan</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="semester_id">Semester ID:</label>
                    <select id="semester_id" name="semester_id" bind:value={formData.semester_id} required>
                        {#each semesterData as sems}
                            <option value={sems.semester_id}>{sems.semester_id}</option>
                        {/each}
                    </select>
                </div>

                <div class="form-group">
                    <label for="kd_prodi">Program Studi</label>
                    <select id="kd_prodi" name="kd_prodi" bind:value={formData.kd_prodi} required>
                        {#each prodiData as prodi}
                            <option value={prodi.kd_prodi}>{prodi.nama_prodi}</option>
                        {/each}
                    </select>
                </div>

                <button type="submit" class="submit-button">Simpan</button>
            </form>
        </div>
    </div>
</section>

<style>
    section {
        margin: 0;
        font-family: Arial, sans-serif;
        background-color: #C2C8DA;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }

    .main {
        flex: 1;
        display: flex;
        justify-content: center;
        align-items: center;
        background-color: #C2C8DA;
        height: 100vh;
        flex-wrap: wrap;
    }

    .main .form-container {
        width: 100%;
        max-width: 700px;
        background-color: #C2C8DA;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        overflow: hidden;
        margin: 20px;
    }

    .form-header {
        background-color: #6a1b9a;
        color: white;
        font-size: 25px;
        font-weight: bold;
        padding: 15px;
        text-align: left;
    }

    .form-body {
        padding: 20px;
        display: flex;
        flex-direction: column;
        gap: 15px;
    }

    .form-group {
        display: flex;
        flex-direction: column;
        gap: 5px;
    }

    label {
        font-size: 14px;
        font-weight: bold;
        color: #333;
    }

    input,
    select,
    textarea {
        padding: 10px;
        border: 1px solid #763497;
        border-radius: 4px;
        font-size: 14px;
        background-color: #C2C8DA;
    }

    input:focus,
    select:focus {
        outline: none;
        border-color: #6a1b9a;
    }

    .submit-button {
        padding: 10px;
        background-color: #6a1b9a;
        color: white;
        border: none;
        border-radius: 4px;
        font-size: 14px;
        cursor: pointer;
        align-self: flex-start; /* Align button to the left */
    }

    .submit-button:hover {
        background-color: #501380;
    }

    /* Minimize*/
    @media (max-width: 768px) {
        .form-container {
            width: 90%;
        }
    }

    @media (max-width: 480px) {
        .sidebar {
            display: none;
        }

        .main {
            padding: 10px;
        }
    }
</style>

