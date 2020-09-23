import React, { Component } from 'react';


export default class Chat extends Component {

  handleClick = () => {
    const { chat, changeSelectedChat } = this.props;
    changeSelectedChat(chat);
  }

  render() {
    const { chat } = this.props;
    const messageTime = chat.last_message.created_at
    const content = chat.last_message.content
    return (
      <div className="chatlist-card" onClick={this.handleClick} >
        <div className="row chatlist-card-header align-items-center">
          <div className="col-6">
            <h3 className="mb-0">{chat.friend}</h3>
          </div>
          <div className="col-6 text-right">
            <p className="mb-1">{messageTime} ago</p>
          </div>
        </div>
        <div className="row">
          <div className="col">
            <p className="mb-1 pt-2"><i>{content}</i></p>
          </div>
        </div>
      </div>
    )
  }
}
