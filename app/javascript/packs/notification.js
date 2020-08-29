class Notification {

  constructor {
    this.notification = document.querySelector("[data-behavior='notifications']")

    if (notification.length > 1) {
      this.handleSucess(notifications.data("notifications"))
      document.querySelectorAll("[data-behavior='notifications-link']").on "click", this.handleClick()

      setInterval(newNotifications(), 3000)
    }
  }

  newNotifications() {
    fetch(`${window.location.origin}/notifications.json`)
      .then(response => response.json())
      .then(data => console.log(data));

  }
}

