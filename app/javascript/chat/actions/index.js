const BASE_URL = '/api/v1';

export default function fetchChatrooms() {
  const url = `${BASE_URL}/chatrooms`
  const promise = fetch(url, { credentials: "same-origin"}).then(r => r.json());

  return {
    // type: FETCH_CHATROOMS,
    promise
  };
}

