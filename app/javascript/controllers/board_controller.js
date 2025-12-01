import { Controller } from '@hotwired/stimulus';
import { Sortable } from 'sortablejs';

export default class extends Controller {
  connect() {
    this.lists = this.element.querySelectorAll('[data-list-id]');

    this.lists.forEach((list) => {
      new Sortable(list, {
        group: 'cards',
        animation: 150,
        onEnd: (evnt) => {
          const cardId = evnt.item.dataset.cardId;
          const newListId = list.dataset.listId;
          const newPosition = evnt.newIndex + 1;

          fetch(`/cards/${cardId}/update_position`, {
            method: 'PATCH',
            headers: {
              'Content-Type': 'application/json',
              'X-CSRF-Token': document.querySelector("[name='csrf-token']").content,
            },

            body: JSON.stringify({
              list_id: newListId,
              position: newPosition,
            }),
          });
        },
      });
    });
  }
}
