import React, { Component } from 'react';
import { Link } from 'react-router-dom';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';

import Chat from './chat';

export default class ChatList extends Component {

  render() {
    const {chats, changeSelectedChat} = this.props
    return (
      <div className="col-4 chatroom-list">
        <div>
          { chats.map(chat => <Chat chat={chat} key={chat.id} changeSelectedChat={changeSelectedChat} />) }
        </div>
      </div>
    );
  }

}


