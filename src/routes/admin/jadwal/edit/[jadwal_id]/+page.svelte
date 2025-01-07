<script>
    import axios from "axios";
    import {onMount} from "svelte";
    import {page} from "$app/stores";

    const jadwal_id = $page.params.jadwal_id;
    let jadwalData;

    let formData = {
        kd_mk: '',
        waktu: '',
    };

    async function loadJadwalData() {
        try {
            const response = await axios.get(`/api/jadwal/${jadwal_id}`);

            const jadwalData = await response.data.jadwal[0];

            console.log(jadwalData)
            formData = {
                ...formData,
                ...jadwalData[0]
            };
        } catch (error) {
            console.error('Error:', error);
        }
    }

    async function handleSubmit() {
        try {
            const response = await axios.put(`/api/jadwal/${jadwal_id}`, {
                ...formData,
            });

            // if (!response.status !== 200) {
            //   throw new Error('Network response was not ok');
            // }

            const result = await response.data;
            alert('Data submitted successfully!');

            // Reset form
            formData = {
                kd_mk: '',
                waktu: '',
            };
        } catch (error) {
            console.error('Error:', error);
            alert('Failed to submit data');
        }
    }

    onMount(async () => {
        await loadJadwalData();
    })
</script>

<section>
    <div class="main">
        <div class="form-container">
            <div class="form-header">
                + Edit Jadwal
            </div>
            <form class="form-body" on:submit|preventDefault={handleSubmit}>
                <div class="form-group">
                    <label for="kd_mk">Kode Mata Kuliah</label>
                    <input
                            type="text"
                            id="kd_mk"
                            name="kd_mk"
                            value={`${formData.kd_mk} | ${formData.mata_kuliah}` }
                            readonly
                    />
                </div>

                <div class="form-group">
                    <label for="waktu">Waktu</label>
                    <input
                            type="date"
                            id="waktu"
                            name="waktu"
                            bind:value={formData.waktu}
                            required
                    />
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
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        width: 100%;
    }

    .main {
        flex: 1;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        flex-wrap: wrap;
        padding: 10px;
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

