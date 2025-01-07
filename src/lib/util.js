export async function getParams(url, name) {
  return url.searchParams.get(name);
}

export function getUser (localStorage) {
  return JSON.parse(localStorage.getItem('mahasiswa'));
}

export function loginUser (localstorage, data) {
  localstorage.setItem('mahasiswa', JSON.stringify(data));
}

export function logoutUser (localStorage) {
  localStorage.removeItem('mahasiswa');
}