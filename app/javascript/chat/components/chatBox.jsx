import React, { Component } from 'react';
import { Link } from 'react-router-dom';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';

import {fetchChatrooms, fetchMessages} from '../actions/index';
import Message from './message';

export default class ChatBox extends Component {

  render() {
    const {messages} = this.props;
    return (
      <div className="col-8 chatbox">
        <div className="chatbox-details">
          <div className="row">
            <div className="col">
              <h3>name here</h3>
            </div>
          </div>
        </div>
        <div className="chatbox-messages">
          { messages.map(message => message.map(m => <Message content={m.content} author={m.user_id} time={m.created_at}  key={m.id} />)) }
        </div>
        <div className="chatbox-user-input">
          <p>submit your message here</p>
        </div>
      </div>
    );
  }

}
