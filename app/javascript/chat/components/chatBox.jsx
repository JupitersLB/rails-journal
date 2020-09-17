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
    const {messages, chatFriend, chatId} = this.props;
    return (
      <div className="col-8 chatbox">
        <div className="chatbox-details">
          <div className="row">
            <div className="col">
              <h3>{chatFriend}</h3>
            </div>
          </div>
        </div>
        <div className="chatbox-messages">
          { messages.map(message => message.map(m => <Message content={m.content} author={m.username} time={m.created_at}  key={m.id} />)) }
        </div>
        <div className="chatbox-user-input">
          <MessageForm chatId={chatId}/>
        </div>
      </div>
    );
  }

}
