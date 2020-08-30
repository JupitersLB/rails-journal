class Notification {

  constructor() {
    this.notification = document.querySelector("[data-behavior='notifications']")

    if (this.notification) {
      // this.handleSucess(this.notification.dataset.behavior)
      let links = document.querySelectorAll("[data-behavior='notifications-link']")
      links.forEach((link) => {
        link.addEventListener('click', this.handleClick());
      })

      setInterval(this.newNotifications(), 3000)
    }
  }

  newNotifications() {
    fetch(`${window.location.origin}/notifications.json`)
      .then(response => response.json())
      .then(data => this.handleSucess(data));
  }

  handleClick(e) {
    fetch(`${window.location.origin}/notifications/mark_as_read`, {
      method: 'PATCH'
    })
    // .then(response => {
    //   if (response.ok) {
    //     response.json()}
    //   })
    // .then(data => console.log(data))
    // .then(data => handleSucess(data));
    .then(response => {
      if (response.ok) {
        document.querySelector("[data-behavior='unread-count']").innerHTML = '';
        document.querySelector("[data-behavior='notification-bell']").classList.remove('notify');
        document.querySelector("[data-behavior='unread-count']").classList.remove('notification-count');
      }
    })
  }

  handleSucess(data) {
    let items = data.map((notification) => {
      return notification.template;
    });
    this.unread_count = 0
    data.forEach((notification) => {
      if (notification.unread)
        document.querySelector("[data-behavior='notification-bell']").classList.add('notify')
        this.unread_count += 1
    })

    if (this.unread_count > 0)
      document.querySelector("[data-behavior='unread-count']").innerHTML = this.unread_count;
      document.querySelector("[data-behavior='unread-count']").classList.add('notification-count')

    document.querySelector("[data-behavior='notification-items']").insertAdjacentHTML('afterbegin', items)
  }
}

new Notification;

