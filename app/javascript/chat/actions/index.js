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

export function createMessage(id, content) {
  const url = `${BASE_URL}/chatrooms/${id}/messages`;
  const body = { content };
  const csrfToken = document.querySelector('meta[name="csrf-token"]').attributes.content.value;
  const promise = fetch(url, {
    method: 'POST',
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'X-CSRF-Token': csrfToken
    },
    credentials: 'same-origin',
    body: JSON.stringify(body)
  }).then(r => r.json());

  return {
    promise
  };
}
