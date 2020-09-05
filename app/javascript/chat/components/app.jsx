import React from 'react';

import ChatList from './chatList'

const App = () => {
  return (
    <div className="container pt-5">
      <div className="chatroom-container">
        <div className="row">
          <ChatList />
          <div className="col-8 chatbox">
        </div>
        </div>
      </div>
    </div>
  );
}

export default App;
