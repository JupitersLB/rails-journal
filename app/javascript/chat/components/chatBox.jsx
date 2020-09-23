import React, { Component } from 'react';
import { Link } from 'react-router-dom';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';

import MessageForm from './messageForm';
import Message from './message';

export default class ChatBox extends Component {

  componentDidMount() { // For the first channel
    const {chat} = this.props
    // this.subscribeActionCable(chat);
  }

  componentDidUpdate() {
    const objDiv = document.querySelector(".chatbox-messages");
    objDiv.scrollTop = objDiv.scrollHeight;
  }

  // componentWillReceiveProps(nextProps) { // For after switching channels
  //   const {chat} = this.props
  //   if (chat.id != nextProps.id) {
  //     this.subscribeActionCable(nextProps);
  //   }
  // }

  // subscribeActionCable = (props) => {
  //   App[`chatroom_${this.props}`] = App.cable.subscriptions.create(
  //     { chatroom: 'ChatroomChannel', name: props.chatId },
  //     {
  //       received: (message) => {
  //         if (message.chatroom_id === props.chatId) {
  //           props.appendMessage(message);
  //         }
  //       }
  //     }
  //   );
  // }

  render() {
    const {messages, chat, chatUser, chatPhoto, chatFriend, chatId} = this.props;
    const url = `user/${chatFriend}`;
    const content = chat.last_seen ? `Last seen ${chat.last_seen} ago` : ''
    return (
      <div className="col-8 chatbox">
        <div className="chatbox-details">
          <div className="row align-items-center justify-content-between">
            <div className="col-6">
              <a href={url}><h3>{chatFriend}</h3></a>
              <p className="mb-1">{content}</p>
            </div>
            <div className="col-2">
              <img className="avatar-big" src={chatPhoto} alt=""></img>
            </div>
          </div>
        </div>
        <div className="chatbox-messages">
          { messages.map(message => message.map(m => <Message content={m.content} user={chatUser} author={m.username} time={m.created_at}  key={m.id} />)) }
        </div>
        <div className="chatbox-user-input">
          <MessageForm chatId={chatId}/>
        </div>
      </div>
    );
  }

}
