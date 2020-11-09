import React, { Component } from 'react';

import { fetchChatrooms, fetchMessages } from '../actions/index';

import ChatList from './chatList';
import ChatBox from './chatBox';

class App extends Component {

  constructor(props) {
    super(props);
    this.state = {
      chats: [],
      selectedChat: '',
      messages: []
    }
  }

  componentDidMount() {
    fetchChatrooms().promise.then(r => r.map(chat => this.setState({
      chats: [...this.state.chats, chat]
    })))
  }

  changeSelectedChat = (newSelectedChat) => {
    this.setState({messages: []})
    this.setState({ selectedChat: newSelectedChat });
    fetchMessages(newSelectedChat.id).promise.then(r => r.map(message => this.setState({
      messages: [...this.state.messages, message]
    })))
  }

  // componentDidUpdate(prevProps, prevState) {
  //   this.state.messages.length !== prevState.messages.length
  // }

  updateMessages = message => {
    this.setState({messages: [...this.state.messages, message]})
  }


  render() {
    const {chats, selectedChat, messages} = this.state
    return (
      <div className="container pt-5">
        <div className="chatroom-container">
          <div className="row">
            <ChatList chats={chats} chat={selectedChat} changeSelectedChat={this.changeSelectedChat} />
            <ChatBox messages={messages} updateMessages={this.updateMessages} chat={selectedChat} chatUser = {selectedChat.user} chatPhoto={selectedChat.photo} chatFriend={selectedChat.friend} chatId={selectedChat.id}/>
          </div>
        </div>
      </div>
    );
  }
}

export default App;
