import consumer from './consumer'
import Rails from '@rails/ujs'

consumer.subscriptions.create({ channel: "VoteChannel", id: document.documentElement.dataset['id'] }, {
  connected() {
    // avoid a race condition between page loading and us establishing the
    // WebSocket connection by doing an extra check after we've connected to
    // ensure we are in the correct state.
    setTimeout(() => this.refreshCurrentStanding(), 0);
  },

  disconnected() {
    // pass
  },

  received(data) {
    if (!data.reload) {
      // pass
    } else if (data.reload === true) {
      location.reload();
    } else if (data.reload.current_standing === true) {
      this.refreshCurrentStanding()
    }
  },

  refreshCurrentStanding() {
    const element = document.querySelector('#current-standing-panel');
    if (!element) {
      return;
    }

    Rails.ajax({
      url: element.dataset['refreshUrl'],
      type: 'GET',
      success: function (_document, _status, xhr) {
        element.innerHTML = xhr.responseText;
      }
    })
  }
});
