import React, { Component } from 'react';

import fetchChatrooms from '../actions/index'

export default class Chat extends Component {

  // handleClick = () => {
  //   const { gifId, changeSelectGif } = this.props;
  //   changeSelectGif(gifId);
  // }



  render() {
    const { chatId, chatFriend } = this.props;
    console.log({chatFriend})
    return (
      <div className="chatlist-card">
        <div className="row chatlist-card-header align-items-center">
          <div className="col-10">
            <h3 className="mb-0">{chatFriend}</h3>
          </div>
          <div className="col-2">
            <div className="active"></div>
          </div>
        </div>
        <div className="row">
          <div className="col">
            <p className="mb-1"></p>
          </div>
        </div>
      </div>
    )
  }
}
