<!-- javascript -->
<script>
	let count = 0;

	function increment() {
		count += 2;
	}
</script>

<!-- html -->
<div>
	<h1 class="header">HALOOOO AKHIRNYA BISA</h1>
	<h2>ijwkms</h2>
	<button on:click={increment}>
		Clicked {count}
		{count === 1 ? 'time' : 'times'}
	</button>
</div>

<!-- css -->
<style>
  .header {
    color: red;
  }
	button {
		padding: 10px 20px;
		font-size: 16px;
		border-radius: 5px;
		background-color: lightblue;
		border: none;
		cursor: pointer;
	}
</style>
