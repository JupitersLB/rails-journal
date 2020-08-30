class Notification {

  constructor {
    notification = document.querySelector("[data-behavior='notifications']")

    if (notification.length > 1) {
      handleSucess(notifications.data("notifications"))
      document.querySelectorAll("[data-behavior='notifications-link']").on "click", handleClick()

      setInterval(newNotifications(), 3000)
    }
  }

  newNotifications() {
    fetch(`${window.location.origin}/notifications.json`)
      .then(response => {
        if (response.ok) {
          response.json()}
        })
      .then(data => console.log(data))
      .then(data => handleSucess(data));
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
        document.querySelector("[data-behavior='unread-count']").text('')
        document.querySelector("[data-behavior='notification-bell']").removeClass('notify')
        document.querySelector("[data-behavior='unread-count']").removeClass('notification-count')
      }
    })
  }

  handleSucess(data) {
    items = data.map((notification) => {
      notification.template
    })

    unread_count = 0
    data.forEach((notification) => {
      if (notification.unread)
        document.querySelector("[data-behavior='notification-bell']").addClass('notify')
        unread_count += 1
    })

    if (unread_count > 0)
      document.querySelector("[data-behavior='unread-count']").text(unread_count)
      document.querySelector("[data-behavior='unread-count']").addClass('notification-count')

    document.querySelector("[data-behavior='notification-items']").html(items)
  }
}

new Notification

