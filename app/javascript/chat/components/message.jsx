import React, { Component } from 'react';

export default class Message extends Component {

  render() {
    const { content, author, time } = this.props;
    return (
      <div className="message-container">
      <i className="author">
        <span>{author}</span>
        <small>{time}</small>
      </i>
      <p>{content}</p>
    </div>
    )
  }
}
