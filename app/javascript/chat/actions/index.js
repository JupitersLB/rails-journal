const BASE_URL = '/api/v1';

export function fetchChatrooms() {
  const url = `${BASE_URL}/chatrooms`
  const promise = fetch(url, { credentials: "same-origin"}).then(r => r.json());

  return {
    // type: FETCH_CHATROOMS,
    promise
  };
}

export function fetchMessages(id) {
  const url = `${BASE_URL}/chatrooms/${id}`
  const promise = fetch(url, { credentials: "same-origin"}).then(r => r.json());

  return {
    // type: FETCH_CHATROOMS,
    promise
  };
}
