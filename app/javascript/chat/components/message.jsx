import React, { Component } from 'react';

export default class Message extends Component {
  render() {
    const { content, author, user } = this.props;
    const position = user === author ? "message-right" : "message-left"
    const time = new Date(this.props.time).toLocaleTimeString()
    return (
      <div className={position}>
        <div className="message-container">
          <i className="author">
            <span>{author}</span>
            <small>{time}</small>
          </i>
          <p>{content}</p>
        </div>
      </div>
    )
  }
}
