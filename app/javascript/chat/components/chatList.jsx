import React, { Component } from 'react';
import { Link } from 'react-router-dom';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';

import fetchChatrooms from '../actions/index';
import Chat from './chat';

export default class ChatList extends Component {

  constructor(props) {
    super(props);
    this.state = { chats: [] }
    // this.fetchChatrooms()
  }

  componentDidMount() {
    // fetchChatrooms().promise.then(r => r.map(chat => console.log(chat)
    fetchChatrooms().promise.then(r => r.map(chat => this.setState({
      chats: [...this.state.chats, chat]
    })))
    // fetchChatrooms().payload.then(r => r.map(chat => this.setState({
    //   chatListId: chat
    // })))
    // this.fetchChatrooms();
  }


  // renderChannel() {
  //   const BASE_URL = '/api/v1';

  //   function fetchChatrooms() {
  //     const promise = fetch(`${BASE_URL}/chatrooms`)
  //       .then(response => response.json());

  //     return {
  //       type: FETCH_CHATROOMS,
  //       payload: promise
  //     };
  //   }

  //   console.log(fetchChatrooms.payload)
  //   return (
  //     <li>
  //       Hello
  //     </li>
  //   )
  // }

  render() {
    const {chats} = this.state
    // chats.map(chat => console.log(chat))
    return (
      <div className="col-4 chatroom-list">
        <span>Chat List</span>
        <div>
          { chats.map(chat => <Chat chatId={chat.id} chatFriend={chat.friend} key={chat.id} />) }
        </div>
      </div>
    );
  }

}


