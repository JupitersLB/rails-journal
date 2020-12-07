class Notification {

  constructor() {
    this.notification = document.querySelector("[data-behavior='notifications']")
    if (this.notification) {
      let link = document.querySelector("[data-behavior='notifications-link']")
      link.addEventListener('click',  this.handleClick);
      setInterval(this.newNotifications, 3000);
    }
  }

  // Check for new notifications

  newNotifications() {
    fetch(`${window.location.origin}/notifications.json`)
      .then(response => response.json())
      .then(data => {
        let items = data.map((notification) => {
          return notification.template;
        });
        this.unread_count = 0
        data.forEach((notification) => {
          // Add class and add to count if any notifications haven't been read
          if (notification.unread) {
            document.querySelector("[data-behavior='notification-bell']").classList.add('notify');
            this.unread_count += 1;
          }

        })

        //  add the number of unread notifications if greater than 0
        if (this.unread_count > 0) {
          document.querySelector("[data-behavior='unread-count']").innerHTML = this.unread_count;
          document.querySelector("[data-behavior='unread-count']").classList.add('notification-count');
        }

        // put the items from the response into the dropdown of notifications
        document.querySelector("[data-behavior='notification-items']").innerHTML = items
      });
  }

  // When notification icon is clicked, mark all notifications as read, remove classes.

  handleClick() {
    fetch(`${window.location.origin}/notifications/mark_as_read`, {
      method: 'PATCH'
    })
      .then(response => response.json())
      .then(data => { if (data.success) {
        document.querySelector("[data-behavior='unread-count']").innerHTML = ''
        document.querySelector("[data-behavior='notification-bell']").classList.remove('notify');
        document.querySelector("[data-behavior='unread-count']").classList.remove('notification-count');
        }
      })
  }
}

new Notification();

