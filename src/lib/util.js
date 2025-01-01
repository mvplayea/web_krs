export async function getParams(url, name) {
  return url.searchParams.get(name);
}