import React, { Component } from 'react';


export default class Chat extends Component {

  handleClick = () => {
    const { chat, changeSelectedChat } = this.props;
    changeSelectedChat(chat);
  }

  render() {
    const { chat } = this.props;
    const time = chat.last_seen
    return (
      <div className="chatlist-card" onClick={this.handleClick} >
        <div className="row chatlist-card-header align-items-center">
          <div className="col-10">
            <h3 className="mb-0">{chat.friend}</h3>
          </div>
          <div className="col-2">
            <div className="active"></div>
          </div>
        </div>
        <div className="row">
          <div className="col">
            <p className="mb-1">Last seen {time} ago</p>
          </div>
        </div>
      </div>
    )
  }
}
