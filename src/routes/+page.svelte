<script>
	let count = 0;

	function increment() {
		count += 1;
	}
</script>

<button on:click={increment}>
	Clicked {count}
	{count === 1 ? 'time' : 'times'}
</button>

<h1>Welcome to nightmare</h1>
<h2>but just kidding! yey</h2>
<p>Visit <a href="https://kit.svelte.dev">kit.svelte.dev</a> to read the documentation</p>

<style>
	button {
		padding: 10px 20px;
		font-size: 16px;
		border-radius: 5px;
		background-color: lightblue;
		border: none;
		cursor: pointer;
	}
</style>
